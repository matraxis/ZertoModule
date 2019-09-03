Function Get-ZertoSiteVApp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoSiteIdentifier)  ) {
        throw "Missing Zerto Site Identifier"
    }
    $FullURL = $baseURL + "virtualizationsites/" + $ZertoSiteIdentifier + "/vapps"
    Write-Verbose $FullURL
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
# .
