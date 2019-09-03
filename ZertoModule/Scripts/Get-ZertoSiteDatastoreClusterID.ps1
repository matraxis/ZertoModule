Function Get-ZertoSiteDatastoreClusterID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier,
        [Parameter(Mandatory = $true, HelpMessage = 'vCenter Datastore Cluster Name')] [string] $DatastoreClusterName
    )
    $ID = Get-ZertoSiteDatastoreCluster -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $ZertoSiteIdentifier | `
        Where-Object { $_.DatastoreClusterName -eq $DatastoreClusterName } | `
        Select-Object DatastoreClusterIdentifier -ExpandProperty DatastoreClusterIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$DatastoreClusterName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$DatastoreClusterName' was not found"
    }
    return $ID.ToString()
}
# .
