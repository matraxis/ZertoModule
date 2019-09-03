Function Get-ZertoVirtualizationSiteID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Name')] [string] $ZertoSiteName
    )
    $ID = Get-ZertoVirtualizationSite -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
        Where-Object { $_.VirtualizationSiteName -eq $ZertoSiteName } | `
        Select-Object SiteIdentifier -ExpandProperty SiteIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$ZertoSiteName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$ZertoSiteName' was not found"
    }
    return $ID.ToString()
}  #endregion  #region Zerto Site Secondarys
# .
