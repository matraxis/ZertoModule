Function Get-ZertoAuthToken  {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer ) ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter( HelpMessage  = 'User to connect to Zerto')] [string] $ZertoUser
)
Set-SSLCertByPass
if ([String]::IsNullOrEmpty($ZertoServer) ) {
throw "Missing Zerto Server"
}
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$FullURL = $baseURL + "session/add"
$TypeJSON = "application/json"
Write-Verbose $FullURL
if ([String]::IsNullOrEmpty($ZertoUser) ) {
$cred = Get-Credential -Message "Enter your Zerto credentials for '$ZertoServer'"
} else {
$cred = Get-Credential -Message "Enter your Zerto credentials for '$ZertoServer'" -UserName $ZertoUser
}
If ($cred -NE $null) {
#Remove  our Zerto Version
Remove-Item ENV:ZertoToken -Force -ErrorAction Ignore
Remove-Item ENV:ZertoVersion -Force -ErrorAction Ignore
# Authenticating with Zerto APIs - Basic AUTH over SSL
$authInfo = ("{0}\{1}:{2}" -f  $cred.GetNetworkCredential().domain ,  $cred.GetNetworkCredential().UserName,  $cred.GetNetworkCredential().Password )
$authInfo = [System.Text.Encoding]::UTF8.GetBytes($authInfo)
$authInfo = [System.Convert]::ToBase64String($authInfo)
$headers = @{Authorization=("Basic {0}" -f $authInfo)}
$sessionBody = '{"AuthenticationMethod": "1"}'
#Need to check our Response.
try {
$xZertoSessionResponse = Invoke-WebRequest -Uri $FullURL -Headers $headers -Method POST -Body $sessionBody -ContentType $TypeJSON
} catch {
$xZertoSessionResponse = $_.Exception.Response
}
if ($xZertoSessionResponse -eq $null  ) {
Throw "Zerto Server ${ZertoServer}:${ZertoPort} not responding."
} elseif ($xZertoSessionResponse.StatusCode -eq "200") {
$xZertoSession = $xZertoSessionResponse.headers.get_item("x-zerto-session")
$ZertoSessionHeader = @{"x-zerto-session"=$xZertoSession}
return $ZertoSessionHeader
} else {
if ($xZertoSessionResponse.StatusCode.value__ -eq "401") {
Throw "User $ZertoUser not authorized or invalid password."
}
return $null
}
} else {
return $null
}
}
#.ExternalHelp ZertoModule.psm1-help.xml
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
