Function Set-ZertoVPGSetting {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Settings Identifier')] [string] $ZertoVpgSettingsIdentifier,
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Settings obejct')] [ZertoVPGSetting] $ZertoVPGSetting
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
if ([string]::IsNullOrEmpty($ZertoVpgSettingsIdentifier)  ) {
throw "Missing Zerto VPG Settings Identifier"
}
$FullURL = $baseURL + "vpgSettings/" + $ZertoVpgSettingsIdentifier
Write-Verbose $FullURL
$Body = $ZertoVPGSetting | ConvertTo-Json -Depth 99
Write-Verbose $Body
try {
$Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method PUT -Body $Body
} catch {
Test-RESTError -err $_
}
return $Result
}
# .
