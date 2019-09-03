Function Get-ZertoAuthToken {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false, 
            HelpMessage = 'Zerto Server or ENV:\ZertoServer'
        )] 
        [ValidateNotNullorEmpty]
        [string] 
        $ZertoServer = ( Get-EnvZertoServer ),

        [Parameter(
            Mandatory = $false, 
            HelpMessage = 'Zerto Server URL Port'
        )] 
        [ValidateRange(0, 65536)]
        [int] 
        $ZertoPort = ( Get-EnvZertoPort ),

        # Credential Object for connection.
        [Parameter(
            Mandatory = $true
        )]
        [PSCredential]
        $Credential
    )
    Set-SSLCertByPass
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $FullURL = $baseURL + "session/add"
    $TypeJSON = "application/json"
    Write-Verbose -Message "Full URL is : $FullURL"

    Write-Verbose -Message "Remove our Zerto Version"
    Remove-Item ENV:ZertoToken -Force -ErrorAction Ignore
    Remove-Item ENV:ZertoVersion -Force -ErrorAction Ignore
    Write-Verbose "Authenticating with Zerto APIs - Basic AUTH over SSL"
    $authInfo = ("{0}\{1}:{2}" -f $Credential.GetNetworkCredential().domain , $Credential.GetNetworkCredential().UserName, $Credential.GetNetworkCredential().Password )
    $authInfo = [System.Text.Encoding]::UTF8.GetBytes($authInfo)
    $authInfo = [System.Convert]::ToBase64String($authInfo)
    $headers = @{Authorization = ("Basic {0}" -f $authInfo) }
    $sessionBody = '{"AuthenticationMethod": "1"}'
    Write-Verbose "Need to check our Response."
    try {
        $xZertoSessionResponse = Invoke-WebRequest -Uri $FullURL -Headers $headers -Method POST -Body $sessionBody -ContentType $TypeJSON
    }
    catch {
        $xZertoSessionResponse = $_.Exception.Response
    }
    if ($xZertoSessionResponse -eq $null  ) {
        Write-Error -Exception "Connection issue" -Message "Zerto Server ${ZertoServer}:${ZertoPort} not responding."
    }
    elseif ($xZertoSessionResponse.StatusCode -eq "200") {
        $xZertoSession = $xZertoSessionResponse.headers.get_item("x-zerto-session")
        $ZertoSessionHeader = @{"x-zerto-session" = $xZertoSession }
        return $ZertoSessionHeader
    }
    else {
        if ($xZertoSessionResponse.StatusCode.value__ -eq "401") {
            Write-Error -Exception "AuthenticationFailed" -Message "User $($Credential.UserName) not authorized or invalid password."
        }
        return $null
    }
}
#.ExternalHelp ZertoModule.psm1-help.xml