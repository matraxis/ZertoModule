Function Set-ZertoAuthToken  {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer ) ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter( HelpMessage  = 'User to connect to Zerto')] [string] $ZertoUser
)
Set-Item ENV:ZertoToken ( (Get-ZertoAuthToken -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoUser $ZertoUser) | ConvertTo-Json -Compress)
#Set our Zerto Version
Set-Item ENV:ZertoVersion (Get-ZertoLocalSite).version
}
# .
