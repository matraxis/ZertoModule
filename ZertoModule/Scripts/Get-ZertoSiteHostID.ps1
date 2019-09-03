Function Get-ZertoSiteHostID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier,
        [Parameter(Mandatory = $true, HelpMessage = 'vCenter Host Name')] [string] $HostName
    )
    $ID = Get-ZertoSiteHost -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $ZertoSiteIdentifier | `
        Where-Object { $_.VirtualizationHostName -eq $HostName } | `
        Select-Object HostIdentifier -ExpandProperty HostIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$HostName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$HostName' was not found"
    }
    return $ID.ToString()
}
# .
