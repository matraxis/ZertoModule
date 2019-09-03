Function Disconnect-ZertoPeerSite {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Identifier of Peersite to disconnect')] [string] $ZertoSiteIdentifier,
        [Parameter(Mandatory = $false, HelpMessage = 'Keep Target Disks in Peer site')] [boolean] $KeepTargetDisks = $false
        , [Parameter(Mandatory = $false, HelpMessage = 'Dump Json without posting for debug')] [switch] $DumpJson
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoSiteIdentifier)  ) {
        throw "Missing Zerto Site Identifier"
    }
    $FullURL = $baseURL + "peersites/" + $ZertoSiteIdentifier
    Write-Verbose $FullURL
    $BodyHash = [ordered] @{ }
    $BodyHash.Add("IsKeepTargetDisks", $KeepTargetDisks)
    $BodyJson = $BodyHash | ConvertTo-Json -Depth 20
    if ($DumpJson ) {
        #Display JSON, and exit
        Write-Host $BodyJson
        return
    }
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Delete -Body $BodyJson
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
#endregion  #region Zerto Service Profiles
# .
