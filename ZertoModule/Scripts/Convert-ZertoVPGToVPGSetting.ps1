Function Convert-ZertoVPGToVPGSetting {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier
        , [Parameter(Mandatory = $false, HelpMessage = 'Dump Json without posting for debug')] [switch] $DumpJson
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
        throw "Missing Zerto VPG Identifier"
    }
    $FullURL = $baseURL + "vpgSettings"
    Write-Verbose $FullURL
    $BodyHash = @{ }
    $BodyHash.Add("VpgIdentifier", $ZertoVpgIdentifier )
    $BodyJson = $BodyHash | ConvertTo-Json
    Write-Verbose $BodyJson
    if ($DumpJson ) {
        #Display JSON, and exit
        Write-Host $BodyJson
        return
    }
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Body $BodyJson -Method Post
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
# .
