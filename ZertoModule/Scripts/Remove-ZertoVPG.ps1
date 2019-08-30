Function Remove-ZertoVPG {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier,
[Parameter(Mandatory=$false, HelpMessage = 'Force Remove')] [Bool] $Force = $false,
[Parameter(Mandatory=$false, HelpMessage = 'Keep Recovery Volumes')] [Bool] $KeepRecoveryVolumes = $false
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
throw "Missing Zerto VPG Identifier"
}
$FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier
Write-Verbose $FullURL
$BodyHash = [ordered] @{}
$BodyHash.Add("Force", $Force)
$BodyHash.Add("KeepRecoveryVolumes", $KeepRecoveryVolumes)
$Body = $BodyHash | ConvertTo-Json
Write-Verbose $Body
try {
$Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Delete -Body $Body
} catch {
Test-RESTError -err $_
}
return $Result
}
# .
