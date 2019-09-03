Function Get-ZertoVRAID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VRA Name')] [string] $VraName
    )
    $ID = Get-ZertoVRA -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
        Where-Object { $_.VraName -eq $VraName } | `
        Select-Object VraIdentifier -ExpandProperty VraIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$VraName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$VraName' was not found"
    }
    return $ID.ToString()
}
# .
