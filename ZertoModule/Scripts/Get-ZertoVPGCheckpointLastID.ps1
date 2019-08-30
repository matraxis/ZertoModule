Function Get-ZertoVPGCheckpointLastID {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier
)
$ID = (Get-ZertoVPGCheckpoint -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgIdentifier $ZertoVpgIdentifier)[-1] |
Select-Object CheckpointIdentifier -ExpandProperty CheckpointIdentifier
return $ID.ToString()
}
# .
