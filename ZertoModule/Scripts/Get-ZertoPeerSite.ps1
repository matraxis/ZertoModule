Function Get-ZertoPeerSite {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Peer Site name')] [string] $PeerName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Peer Site pairing status')] [ZertoPairingStatus] $ParingStatus,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Peer Site location')] [string] $Location,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Peer Site host name')] [string] $HostName,
[Parameter(Mandatory=$false, ParameterSetName="Filter", HelpMessage = 'Zerto Peer Site port')] [string] $Port,
[Parameter(Mandatory=$true, ParameterSetName="ID", HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
switch ($PsCmdlet.ParameterSetName) {
"ID" {
if ([string]::IsNullOrEmpty($ZertoSiteIdentifier)  ) {
throw "Missing Zerto Site Identifier"
}
$FullURL = $baseURL + "peersites/" + $ZertoSiteIdentifier
}
Default {
$FullURL = $baseURL + "peersites"
if ($PeerName -or $ParingStatus -ne $null -or $Location -or $HostName -or $Port) {
$qs = [ordered] @{}
if ($PeerName)
{ $qs.Add("peerName", $PeerName) }
if ($ParingStatus -ne $null) { $qs.Add("paringStatus", $ParingStatus) }
if ($Location)
{ $qs.Add("location", $Location) }
if ($HostName)
{ $qs.Add("hostName", $HostName) }
if ($Port)
{ $qs.Add("port", $Port) }
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
