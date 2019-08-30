Function Add-ZertoVRA {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto Datastore Name')] [string] $DatastoreName,
[Parameter(Mandatory=$False, HelpMessage = 'Zerto VRA Group Name (optional)')] [string] $VRAGroupName,
[Parameter(Mandatory=$true, HelpMessage = 'Zerto Host Name')] [string] $HostName,
[Parameter(Mandatory=$true, HelpMessage = 'Zerto Network Name')] [string] $NetworkName,
[Parameter(Mandatory=$false, HelpMessage = 'Memory in GB for new VRA (1-16, defaults to 16)')] [string] $MemoryInGB = 16,
[Parameter(Mandatory=$true, ParameterSetName="Password", HelpMessage = 'Zerto Host Root Password')] [string] $HostRootPassword,
[Parameter(Mandatory=$true, ParameterSetName="PublicKey", HelpMessage = 'Use vCenter PublicKey instead of Password')] [bool] $UseVCenterPublicKey = $true,
[Parameter(Mandatory=$true, HelpMessage = 'VRA IP Configuration')] [VRAIPAddressConfig] $VRAIPConfiguration
,[Parameter(Mandatory=$false, HelpMessage = 'Dump Json without posting for debug')] [switch] $DumpJson
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
#Validate
if ($UseVCenterPublicKey -and $HostRootPassword) {
throw "Cannot specify both HostRootPassword and Use vCenter Public Key"
}
if ($MemoryInGB -lt 1 -or $MemoryInGB -gt 16) {
throw "Invalid MemoryInGB - must be from 1 to 16"
}
#Get Identifiers
$LocalSiteID = Get-ZertoLocalSiteID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken
if ([string]::IsNullOrEmpty($LocalSiteID)  ) { throw "Could not find Local Site ID" }
$HostID = Get-ZertoSiteHostID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $LocalSiteID -HostName $HostName
$DatastoreID = Get-ZertoSiteDatastoreID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $LocalSiteID -DatastoreName $DatastoreName
$NetworkID = Get-ZertoSiteNetworkID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $LocalSiteID -NetworkName $NetworkName
#Validate IDs
if ([string]::IsNullOrEmpty($DatastoreID)  ) { throw "Could not find Datastore ID for $DatastoreName " }
if ([string]::IsNullOrEmpty($HostID)  ) { throw "Could not find Datastore ID for $DatastoreName " }
if ([string]::IsNullOrEmpty($NetworkID)  ) { throw "Could not find  Network ID for $NetworkName " }
$FullURL = $baseURL + "vras"
Write-Verbose $FullURL
$BodyHash = [ordered] @{}
$BodyHash.Add("DatastoreIdentifier", $DatastoreID)
$BodyHash.Add("GroupName", $VRAGroupName)
$BodyHash.Add("HostIdentifier", $HostID)
If ($HostRootPassword) {
$BodyHash.Add("HostRootPassword", $HostRootPassword)
$BodyHash.Add("UsePublicKeyInsteadOfCredentials", $false)
} else {
$BodyHash.Add("HostRootPassword", $null)
$BodyHash.Add("UsePublicKeyInsteadOfCredentials", $UseVCenterPublicKey)
}
$BodyHash.Add("MemoryInGb", $MemoryInGB)
$BodyHash.Add("NetworkIdentifier", $NetworkID)
$NewVRAIPInfo = [ordered] @{}
$NewVRAIPInfo.Add("DefaultGateway", $VRAIPConfiguration.Gateway )
$NewVRAIPInfo.Add("SubnetMask", $VRAIPConfiguration.SubnetMask )
$NewVRAIPInfo.Add("VraIPAddress", $VRAIPConfiguration.IPAddress )
$NewVRAIPInfo.Add("VraIPConfigurationTypeApi", $VRAIPConfiguration.VRAIPType.ToString() )
$BodyHash.Add("VraNetworkDataApi", $NewVRAIPInfo)
#Convert VPG Hash to JSON - Remember DEPTH!!!
$BodyJson = $BodyHash | ConvertTo-Json -Depth 20
Write-Verbose $NewVRAJson
if ($DumpJson ) {
#Display JSON, and exit
Write-host $BodyJson
return
}
try {
$Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Post -Body $BodyJson
} catch {
Test-RESTError -err $_
}
return $Result
}
# .
