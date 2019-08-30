Function Get-ZertoLocalSiteID {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken )
)
$ID = Get-ZertoLocalSite -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
Select-Object SiteIdentifier -ExpandProperty SiteIdentifier
return $ID.ToString()
}
# .
