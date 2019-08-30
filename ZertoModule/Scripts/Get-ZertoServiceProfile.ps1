Function Get-ZertoServiceProfile {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier,
[Parameter(Mandatory=$true, ParameterSetName="ID", HelpMessage = 'Zerto Service Profile Identifier')] [string] $ZertoServiceProfileIdentifier
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
switch ($PsCmdlet.ParameterSetName) {
"ID" {
if ([string]::IsNullOrEmpty($ZertoServiceProfileIdentifier)  ) {
throw "Missing Zerto Service Profile Identifier"
}
$FullURL = $baseURL + "serviceprofiles/" + $ZertoServiceProfileIdentifier
}
Default {
$FullURL = $baseURL + "serviceprofiles"
if ($ZertoSiteIdentifier) {
$qs = [ordered] @{}
if ($SiteIdentifier) { $qs.Add("Site", $ZertoSiteIdentifier) }
$FullURL += Get-QueryStringFromHashTable -QueryStringHash $QS
}
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
