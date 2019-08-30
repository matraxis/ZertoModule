Function Connect-ZertoZVM {
[CmdletBinding()]
param(
[Parameter(Mandatory=$true, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = 9669 ,
[Parameter(Mandatory=$false, HelpMessage  = 'User to connect to Zerto')] [string] $ZertoUser
)
Set-Item ENV:ZertoServer $ZertoServer
Set-Item ENV:ZertoPort  $ZertoPort
Set-Item ENV:ZertoToken ((Get-ZertoAuthToken -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoUser $ZertoUser) | ConvertTo-Json -Compress)
Set-Item ENV:ZertoVersion (Get-ZertoLocalSite).version
}
# .
