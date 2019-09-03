Function Get-ZertoSiteFolderID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto vCenter Folder Name')] [string] $FolderName
    )
    $ID = Get-ZertoSiteFolder -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $ZertoSiteIdentifier | `
        Where-Object { $_.FolderName -eq $FolderName } | `
        Select-Object FolderIdentifier -ExpandProperty FolderIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$FolderName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$FolderName' was not found"
    }
    return $ID.ToString()
}
# .
