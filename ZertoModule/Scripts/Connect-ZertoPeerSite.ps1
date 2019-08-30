Function Connect-ZertoPeerSite {
[CmdletBinding()]
param(
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
[Parameter(Mandatory=$false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
[Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
[Parameter(Mandatory=$true, ParameterSetName="Post", HelpMessage = 'Address or DNS name of new site')] [string] $HostName,
[Parameter(Mandatory=$false, ParameterSetName="Post", HelpMessage = 'The default port used for communication between paired Zerto Virtual Managers. The default port is 9081.')] [int] $Port = 9081
,[Parameter(Mandatory=$false, HelpMessage = 'Dump Json without posting for debug')] [switch] $DumpJson
)
$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
$TypeJSON = "application/json"
if ( $ZertoToken -eq $null) {
throw "Missing Zerto Authentication Token"
}
if ( $HostName -eq $null) {
throw "Missing new site HostName"
}
if ( $Port -eq $null) {
throw "Missing new site Port"
}
If (-Not (Test-Connection $HostName -Count 1 -Quiet) ) {
throw "Could not ping '$hostname'"
}
$testport = 0
If ( -Not ([int]::TryParse($port, [ref] $testport) ) ) {
throw "Invaild port '$port'. Must be a postive integer."
}
If ( ($port -le 0) -or ($Port -gt [math]::Pow(2,16) )  ) {
throw ("Invaild port '$port'. Must be > 0 and < " + ([math]::Pow(2,16)))
}
$FullURL = $baseURL + "peersites"
Write-Verbose $FullURL
$BodyHash = [ordered] @{}
$BodyHash.Add("HostName", $HostName)
$BodyHash.Add("Port", $Port)
$BodyJson = $BodyHash | ConvertTo-Json -Depth 20
if ($DumpJson ) {
#Display JSON, and exit
Write-host $BodyJson
return
}
try {
$Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Post -Body $BodyJson
} catch {
Test-RESTError -err $_
}
return $Result
}
# .
