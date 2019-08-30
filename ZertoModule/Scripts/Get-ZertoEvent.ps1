Function Get-ZertoEvent {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Event Start Date (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS)')] [string] $StartDate,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Event End Date (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS)')] [string] $EndDate,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VPG Identifier')] [string] $VPGIdentifier,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Alert Entity')] [ZertoEventType] $EventType,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Site Name')] [string] $SiteName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Site Identifier')] [string] $SiteIdentifier,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto ZORG Identifier')] [ZertoEventType] $ZORGIdentifier,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Alert Entity Type')] [ZertoAlertEntity] $EntityType,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto User Name')] [string] $UserName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Event Category')] [ZertoEventCategory] $EventCategory,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Alert Identifier')] [string] $ZertoAlertIdentifier,
[Parameter(Mandatory=$true,  ParameterSetName="ID", HelpMessage = 'Zerto Event Identifier')] [string] $ZertoEventIdentifier
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
switch ($PsCmdlet.ParameterSetName) {
"ID" {
if ([string]::IsNullOrEmpty($ZertoEventIdentifier)  ) {
throw "Missing Zerto Event Identifier"
}
$FullURL = $baseURL + "events/" + $ZertoEventIdentifier
}
Default {
$FullURL = $baseURL + "events"
if ($StartDate -or $EndDate -or $VPGIdentifier -or $EventType -ne $null -or $SiteName -or $SiteIdentifier -or $ZORGIdentifier `
-or $EntityType  -ne $null -or $UserName -or $EventCategory -ne $null -or $ZertoAlertIdentifier) {
$qs = [ordered] @{}
if ($StartDate)
{ if (Parse-ZertoDate($StartDate)) { $qs.Add("StartDate", $StartDate) } else { throw "Invalid StartDate: '$StartDate'" } }
if ($EndDate)
{ if (Parse-ZertoDate($EndDate))
{ $qs.Add("EndDate",
$EndDate)
} else { throw "Invalid EndDate: '$EndDate'" } }
if ($VPGIdentifier)
{ $qs.Add("VPGIdentifier", $VPGIdentifier) }
if ($EventType -ne $null)
{ $qs.Add("EventType", $EventType) }
if ($SiteName)
{ $qs.Add("siteName", $SiteName) }
if ($SiteIdentifier)
{ $qs.Add("SiteIdentifier", $SiteIdentifier) }
if ($EntityType -ne $null)
{ $qs.Add("EntityType", $EntityType) }
if ($ZORGIdentifier)
{ $qs.Add("ZORGIdentifier", $ZORGIdentifier) }
if ($UserName)
{ $qs.Add("UserName", $UserName) }
if ($EventCategory -ne $null)  { $qs.Add("EventCategory", $EventCategory) }
if ($ZertoAlertIdentifier)
{ $qs.Add("ZertoAlertIdentifier", $ZertoAlertIdentifier) }
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
