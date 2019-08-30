Function Invoke-ZertoVPGFailoverCommit {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Reverse Protection')] [bool] $ReverseProtection = $true
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
throw "Missing Zerto VPG Identifier"
}
$FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier + "/failovercommit"
Write-Verbose $FullURL
$BodyHash = [ordered] @{}
$BodyHash.Add("IsReverseProtection", $ReverseProtection)
$BodyJson = $BodyHash | ConvertTo-Json -Depth 20
Write-Verbose $BodyJson
if ($DumpJson ) {
#Display JSON, and exit
Write-host $BodyJson
return
}
try {
$Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method POST -Body $BodyJson
} catch {
Test-RESTError -err $_
}
return $Result
}
# .
