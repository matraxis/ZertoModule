Function Get-ZertoSiteRepositoryID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Backup Repository Name')] [string] $RepositoryName
    )
    $ID = Get-ZertoSiteRepository -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $ZertoSiteIdentifier | `
        Where-Object { $_.DisplayName -eq $RepositoryName } | `
        Select-Object ID  -ExpandProperty ID
    if ($ID.Count -gt 1) {
        Throw "'$RepositoryName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$RepositoryName' was not found"
    }
    return $ID.ToString()
} #endregion  #region Zerto Tasks
# .
