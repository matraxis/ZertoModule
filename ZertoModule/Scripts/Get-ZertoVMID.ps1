Function Get-ZertoVMID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VM Name')] [string] $VmName
    )
    $ID = Get-ZertoVM -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
        Where-Object { $_.VmName -eq $VmName } | `
        Select-Object VmIdentifier -ExpandProperty VmIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$VMName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$VMName' was not found"
    }
    return $ID.ToString()
} #endregion  #region Zerto VRAs
# .
