Function Get-ZertoVPGCheckpointID {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier,
[Parameter(Mandatory=$true, ParameterSetName="Tag", HelpMessage = 'Zerto Checkpoint Tag')] [string] $ZertoVpgCheckpointTag
)
#if ($ZertoVpgCheckpointIdentifier) {
#
$ID =  Get-ZertoVPGCheckpoint -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgIdentifier $ZertoVpgIdentifier | `
#
Where-Object {$_.CheckpointIdentifier -eq $ZertoVpgCheckpointIdentifier} | `
#
Select-Object CheckpointIdentifier -ExpandProperty CheckpointIdentifier
#} elseif ($ZertoVpgCheckpointTag) {
#
$ID =  Get-ZertoVPGCheckpoint -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgIdentifier $ZertoVpgIdentifier | `
#
Where-Object {$_.Tag -eq $ZertoVpgCheckpointTag} | `
#
Select-Object CheckpointIdentifier -ExpandProperty CheckpointIdentifier
#}
$ID =  Get-ZertoVPGCheckpoint -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgIdentifier $ZertoVpgIdentifier | `
Where-Object {$_.Tag -eq $ZertoVpgCheckpointTag} | `
Select-Object CheckpointIdentifier -ExpandProperty CheckpointIdentifier
if ($ID.Count -gt 1) {Throw "'$ZertoVpgCheckpointTag' returned more than one ID"}
if ($ID.Count -eq 0) {Throw "'$ZertoVpgCheckpointTag' was not found"}
return $ID.ToString()
}
# .
