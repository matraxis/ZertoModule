Function Update-ZertoVRA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VRA Identifier')] [string] $ZertoVraIdentifier,
        [Parameter(Mandatory = $False, HelpMessage = 'Zerto VRA Group Name (optional)')] [string] $VRAGroupName,
        [Parameter(Mandatory = $true, ParameterSetName = "Password", HelpMessage = 'Zerto Host Root Password')] [string] $HostRootPassword,
        [Parameter(Mandatory = $true, ParameterSetName = "PublicKey", HelpMessage = 'Use vCenter PublicKey instead of Password')] [bool] $UseVCenterPublicKey = $true,
        [Parameter(Mandatory = $true, HelpMessage = 'VRA IP Configuration')] [VRAIPAddressConfig] $VRAIPConfiguration
        , [Parameter(Mandatory = $false, HelpMessage = 'Dump Json without posting for debug')] [switch] $DumpJson
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    #Validate
    if ($UseVCenterPublicKey -and $HostRootPassword) {
        throw "Cannot specify both HostRootPassword and Use vCenter Public Key"
    }
    #Get Identifiers
    $LocalSiteID = Get-ZertoLocalSiteID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken
    if ([string]::IsNullOrEmpty($LocalSiteID)  ) {
        throw "Could not find Local Site ID" 
    }
    $FullURL = $baseURL + "vras/" + $ZertoVraIdentifier
    Write-Verbose $FullURL
    $BodyHash = [ordered] @{ }
    $BodyHash.Add("GroupName", $VRAGroupName)
    If ($HostRootPassword) {
        $BodyHash.Add("HostRootPassword", $HostRootPassword)
        $BodyHash.Add("UsePublicKeyInsteadOfCredentials", $false)
    }
    else {
        $BodyHash.Add("HostRootPassword", $null)
        $BodyHash.Add("UsePublicKeyInsteadOfCredentials", $UseVCenterPublicKey)
    }
    $NewVRAIPInfo = [ordered] @{ }
    $NewVRAIPInfo.Add("DefaultGateway", $VRAIPConfiguration.Gateway )
    $NewVRAIPInfo.Add("SubnetMask", $VRAIPConfiguration.SubnetMask )
    $NewVRAIPInfo.Add("VraIPAddress", $VRAIPConfiguration.IPAddress )
    $NewVRAIPInfo.Add("VraIPConfigurationTypeApi", $VRAIPConfiguration.VRAIPType.ToString() )
    $BodyHash.Add("VraNetworkDataApi", $NewVRAIPInfo)
    #Convert VPG Hash to JSON - Remember DEPTH!!!
    $BodyJson = $BodyHash | ConvertTo-Json -Depth 20
    Write-Verbose $BodyJson
    if ($DumpJson ) {
        #Display JSON, and exit
        Write-Host $BodyJson
        return
    }
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Put -Body $BodyJson
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}