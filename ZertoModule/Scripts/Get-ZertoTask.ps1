Function Get-ZertoTask {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Task Started Before Date (YYYY-MM-DD)')] [string] $StartedBeforeDate,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Task Started After Date')] [string] $StartedAfterDate,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Task Completed Before Date (YYYY-MM-DD)')] [string] $CompletedBeforeDate,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Task Completed After Date')] [string] $CompletedAfterDate,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Task Type')] [ZertoTaskTypes] $TaskType,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Task Status')] [string] $Status,
[Parameter(Mandatory=$true, ParameterSetName="ID", HelpMessage = 'Zerto Task Identifier')] [string] $ZertoTaskIdentifier
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
switch ($PsCmdlet.ParameterSetName) {
"ID" {
if ([string]::IsNullOrEmpty($ZertoTaskIdentifier)  ) {
throw "Missing Zerto Task Identifier"
}
#Zerto Returns TASK id's using a ':' as a separator - this needs to be a '.' for the API
if ($ZertoTaskIdentifier -match ':') {
$ZertoTaskIdentifier = $ZertoTaskIdentifier -replace ':','.'
}
$FullURL = $baseURL + "tasks/" + $ZertoTaskIdentifier
}
Default {
$FullURL = $baseURL + "tasks"
if ($StartedBeforeDate -or $StartedAfterDate -or $CompletedBeforeDate -or $CompletedAfterDate -or $TaskType -ne $null -or $Status) {
$qs = [ordered] @{}
if ($StartedBeforeDate)
{ if (Parse-ZertoDate($StartedBeforeDate))
{ $qs.Add("startedBeforeDate",
$StartedBeforeDate)
} else { throw "Invalid StartedBeforeDate: '$StartedBeforeDate'" } }
if ($StartedAfterDate)
{ if (Parse-ZertoDate($StartedAfterDate))
{ $qs.Add("startedAfterDate",
$StartedAfterDate)
} else { throw "Invalid StartedAfterDate: '$StartedAfterDate'" } }
if ($CompletedBeforeDate) { if (Parse-ZertoDate($CompletedBeforeDate))  { $qs.Add("completedBeforeDate", $CompletedBeforeDate) } else { throw "Invalid CompletedBeforeDate: '$CompletedBeforeDate'" } }
if ($CompletedAfterDate)  { if (Parse-ZertoDate($CompletedAfterDate))
{ $qs.Add("completedAfterDate",  $CompletedAfterDate)  } else { throw "Invalid CompletedAfterDate: '$CompletedAfterDate'" } }
if ($TaskType -ne $null)  { $qs.Add("type", $TaskType) }
if ($Status)
{ $qs.Add("status", $Status) }
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
