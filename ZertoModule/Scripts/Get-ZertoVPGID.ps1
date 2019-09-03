Function Get-ZertoVPGID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Name')] [string] $VpgName
    )
    $ID = Get-ZertoVPG -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
        Where-Object { $_.VpgName -eq $VpgName } | `
        Select-Object VpgIdentifier -ExpandProperty VpgIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$VpgName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$VpgName' was not found"
    }
    return $ID.ToString()
}
# .
