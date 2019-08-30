Function Get-ZertoVM {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VPG name')] [string] $VPGName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VM name')] [string] $VMName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VM Status')] [ZertoVPGStatus] $Status,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VM Substatus')] [ZertoVPGSubstatus] $SubStatus,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Protected Site Type')] [ZertoProtectedSiteType] $ProtectedSiteType,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Recovery Site Type')] [ZertoRecoverySiteType] $RecoverySiteType,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Protected Site Identifier')] [string] $ProtectedSiteIdentifier,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Recovery Site Identifier')] [string] $RecoverySiteIdentifier,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VM Organization Name')] [string] $OrganizationName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto VM Priority')] [ZertoVPGPriority] $Priority,
[Parameter(Mandatory=$true, ParameterSetName="ID", HelpMessage = 'Zerto VM Identifier')] [string] $ZertoVMIdentifier
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
switch ($PsCmdlet.ParameterSetName) {
"ID" {
if ([string]::IsNullOrEmpty($ZertoVMIdentifier)  ) {
throw "Missing Zerto VM Identifier"
}
$FullURL = $baseURL + "vms/" + $ZertoVMIdentifier
}
Default {
$FullURL = $baseURL + "vms"
if ($VPGName -or $VMName -or $Status -ne $null -or $Substatus -ne $null -or `
$ProtectedSiteType -ne $null -or $RecoverySiteType -ne $null -or $ProtectedSiteIdentifier -or $RecoverySiteIdentifier -or $OrganizationName `
-or $Priority -ne $null) {
$qs = [ordered] @{}
if ($VPGName)
{ $qs.Add("vpgName", $VPGName) }
if ($VMName)
{ $qs.Add("vmName", $VMName) }
if ($Status -ne $null)
{ $qs.Add("status", $Status) }
if ($Substatus -ne $null)
{ $qs.Add("substatus", $Substatus) }
if ($ProtectedSiteType -ne $null) { $qs.Add("protectedSiteType", $ProtectedSiteType) }
if ($RecoverySiteType -ne $null)  { $qs.Add("recoverySiteType", $RecoverySiteType) }
if ($ProtectedSiteIdentifier)
{ $qs.Add("ProtectedSiteIdentifier", $ProtectedSiteIdentifier) }
if ($RecoverySiteIdentifier)
{ $qs.Add("RecoverySiteIdentifier", $RecoverySiteIdentifier) }
if ($OrganizationName)
{ $qs.Add("organizationName", $OrganizationName) }
if ($Priority -ne $null)
{ $qs.Add("priority", $Priority) }
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
