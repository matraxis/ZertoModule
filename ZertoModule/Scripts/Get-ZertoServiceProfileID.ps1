Function Get-ZertoServiceProfileID {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Site Identifier')] [string] $SiteIdentifier,
[Parameter(Mandatory=$true, HelpMessage = 'Zerto Service Profile Name')] [string] $ZertoServiceProfileName
)
$ID = Get-ZertoServiceProfile -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -SiteIdentifier $SiteIdentifier | `
Where-Object {$_.ServiceProfileName -eq $ZertoServiceProfileName} | `
Select-Object ServiceProfileIdentifier -ExpandProperty ServiceProfileIdentifier
if ($ID.Count -gt 1) {Throw "'$ZertoServiceProfileName' returned more than one ID"}
if ($ID.Count -eq 0) {Throw "'$ZertoServiceProfileName' was not found"}
return $ID.ToString()
} #endregion  #region Zerto Virtualization Sites
# .
