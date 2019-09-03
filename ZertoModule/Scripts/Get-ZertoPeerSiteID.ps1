Function Get-ZertoPeerSiteID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto PeerSite Name')] [string] $ZertoPeerSiteName
    )
    $ID = Get-ZertoPeerSite -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
        Where-Object { $_.PeerSiteName -eq $ZertoPeerSiteName } | `
        Select-Object SiteIdentifier -ExpandProperty SiteIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$ZertoPeerSiteName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$ZertoPeerSiteName' was not found"
    }
    return $ID.ToString()
}
# .
