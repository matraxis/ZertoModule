Function Get-ZertoVPGSettingVM {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Settings Identifier')] [string] $ZertoVpgSettingsIdentifier,
[Parameter(Mandatory=$false, ParameterSetName="ID", HelpMessage = 'Zerto VM Identifier')] [string] $ZertoVmIdentifier
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
if ([string]::IsNullOrEmpty($ZertoVpgSettingsIdentifier)  ) {
throw "Missing Zerto VPG Settings Identifier"
}
switch ($PsCmdlet.ParameterSetName) {
"ID" {
if ([string]::IsNullOrEmpty($ZertoVmIdentifier)  ) {
throw "Missing Zerto VPG Settings VM Identifier"
}
$FullURL = $baseURL + "vpgSettings/" + $ZertoVpgSettingsIdentifier + "/vms/" + $ZertoVmIdentifier
}
Default {
$FullURL = $baseURL + "vpgSettings/" + $ZertoVpgSettingsIdentifier + "/vms"
}
}
Write-Verbose $FullURL
try {
$Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON
} catch {
Test-RESTError -err $_
}
return $Result
}
# .
