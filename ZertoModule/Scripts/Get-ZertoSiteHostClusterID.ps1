Function Get-ZertoSiteHostClusterID {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier,
[Parameter(Mandatory=$true, HelpMessage = 'vCenter Host Cluster Name')] [string] $HostClusterName
)
$ID = Get-ZertoSiteHostCluster -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $ZertoSiteIdentifier | `
Where-Object {$_.VirtualizationClusterName -eq $HostClusterName} | `
Select ClusterIdentifier -ExpandProperty ClusterIdentifier
if ($ID.Count -gt 1) {Throw "'$HostClusterName' returned more than one ID"}
if ($ID.Count -eq 0) {Throw "'$HostClusterName' was not found"}
return $ID.ToString()
}
# .
