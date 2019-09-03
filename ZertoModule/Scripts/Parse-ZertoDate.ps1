Function Parse-ZertoDate {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Zerto Date in the form YYYY-MM-DD or YYYY-MM-DDThh:mm:ss')] [String] $ZertoDate
    )
    try {
        $out = [DateTime]::Parse($ZertoDate) | Out-Null
        Return $True
    }
    catch {
        Return $False
    }
}
Function Test-RESTError {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Error')] [System.Management.Automation.ErrorRecord] $err
    )
    If ($err.Exception -is [System.Net.WebException]) {
        If ($err.Exception.Response.StatusCode.value__ -eq 500) {
            $stream = $err.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd();
            $obj = $responseBody | ConvertFrom-Json
            if ($obj.Message) {
                throw $obj.Message
            }
            else {
                throw $obj
            }
        }
        else {
            throw "Unknown web error: " + $err.Exception.Response.StatusCode.value__ + " : " + $err.Exception.Response.StatusDescription
        }
    }
    else {
        throw "Unknown error: " + $err.Exception
    }
}
Function Convert-ZertoTokenHash {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Zerto Token')] [System.Object] $ZertoToken
    )
    #Saving the token to the ENV as json has to be converted back to hashtable
    if ($ZertoToken -is [String]) {
        try {
            $ZertoToken = $ZertoToken | ConvertFrom-Json
        }
        catch {
            Throw "Invalid Zerto Token - '$ZertoToken'"
        }
    }
    #Round tripping the ZertoToken Hashtable to JSON returns it as a PSCustomObject
    #This converts it back to a hash table from either JSON or string
    if ($ZertoToken -is [PSCustomObject]) {
        $NewHash = @{ }
        $ZertoToken.PSObject.Properties | ForEach-Object {
            $NewHash.Add($_.Name, $_.Value)
        }
        Return $NewHash
    }
    #Already a hash table
    if ($ZertoToken -is [HashTable]) {
        Return $ZertoToken
    }
    Throw "Invalid Zerto Token - '$ZertoToken'"
}
Function Get-EnvZertoServer {
    If ( (Get-Item Env:\ZertoServer -ErrorAction SilentlyContinue) ) {
        return (Get-Item Env:\ZertoServer).Value
    }
}
Function Get-EnvZertoPort {
    If ((Get-Item Env:\ZertoPort -ErrorAction SilentlyContinue) ) {
        Return (Get-Item Env:\ZertoPort).Value
    }
    else {
        Return '9669'
    }
}
Function Get-EnvZertoToken {
    If ((Get-Item Env:\ZertoToken -ErrorAction SilentlyContinue) ) {
        Return Convert-ZertoTokenHash -ZertoToken  (Get-Item Env:\ZertoToken).Value
    }
}
Function StringOrNull {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'String')][AllowEmptyString()] [string] $ThisString
    )
    if ([String]::IsNullOrEmpty($ThisString) ) {
        Return  [NullString]::Value ;
    }
    else {
        Return $ThisString;
    }
}  #endregion  #region Zerto Authentication
#.ExternalHelp ZertoModule.psm1-help.xml
Function Get-ZertoAuthToken {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer ) ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter( HelpMessage = 'User to connect to Zerto')] [string] $ZertoUser
    )
    Set-SSLCertByPass
    if ([String]::IsNullOrEmpty($ZertoServer) ) {
        throw "Missing Zerto Server"
    }
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $FullURL = $baseURL + "session/add"
    $TypeJSON = "application/json"
    Write-Verbose $FullURL
    if ([String]::IsNullOrEmpty($ZertoUser) ) {
        $cred = Get-Credential -Message "Enter your Zerto credentials for '$ZertoServer'"
    }
    else {
        $cred = Get-Credential -Message "Enter your Zerto credentials for '$ZertoServer'" -UserName $ZertoUser
    }
    If ($cred -NE $null) {
        #Remove  our Zerto Version
        Remove-Item ENV:ZertoToken -Force -ErrorAction Ignore
        Remove-Item ENV:ZertoVersion -Force -ErrorAction Ignore
        # Authenticating with Zerto APIs - Basic AUTH over SSL
        $authInfo = ("{0}\{1}:{2}" -f $cred.GetNetworkCredential().domain , $cred.GetNetworkCredential().UserName, $cred.GetNetworkCredential().Password )
        $authInfo = [System.Text.Encoding]::UTF8.GetBytes($authInfo)
        $authInfo = [System.Convert]::ToBase64String($authInfo)
        $headers = @{Authorization = ("Basic {0}" -f $authInfo) }
        $sessionBody = '{"AuthenticationMethod": "1"}'
        #Need to check our Response.
        try {
            $xZertoSessionResponse = Invoke-WebRequest -Uri $FullURL -Headers $headers -Method POST -Body $sessionBody -ContentType $TypeJSON
        }
        catch {
            $xZertoSessionResponse = $_.Exception.Response
        }
        if ($xZertoSessionResponse -eq $null  ) {
            Throw "Zerto Server ${ZertoServer}:${ZertoPort} not responding."
        }
        elseif ($xZertoSessionResponse.StatusCode -eq "200") {
            $xZertoSession = $xZertoSessionResponse.headers.get_item("x-zerto-session")
            $ZertoSessionHeader = @{"x-zerto-session" = $xZertoSession }
            return $ZertoSessionHeader
        }
        else {
            if ($xZertoSessionResponse.StatusCode.value__ -eq "401") {
                Throw "User $ZertoUser not authorized or invalid password."
            }
            return $null
        }
    }
    else {
        return $null
    }
}
#.ExternalHelp ZertoModule.psm1-help.xml
Function Set-ZertoAuthToken {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer ) ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter( HelpMessage = 'User to connect to Zerto')] [string] $ZertoUser
    )
    Set-Item ENV:ZertoToken ( (Get-ZertoAuthToken -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoUser $ZertoUser) | ConvertTo-Json -Compress)
    #Set our Zerto Version
    Set-Item ENV:ZertoVersion (Get-ZertoLocalSite).version
}
# .
