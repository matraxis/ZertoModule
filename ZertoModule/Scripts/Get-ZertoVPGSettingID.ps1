Function Get-ZertoVPGSettingID {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Setting Name')] [string] $VpgSettingName
    )
    $ID = Get-ZertoVPGSetting -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken | `
        Where-Object { $_.Basic.Name -eq $VpgSettingName } | `
        Select-Object VpgSettingsIdentifier -ExpandProperty VpgSettingsIdentifier
    if ($ID.Count -gt 1) {
        Throw "'$VpgSettingName' returned more than one ID"
    }
    if ($ID.Count -eq 0) {
        Throw "'$VpgSettingName' was not found"
    }
    return $ID.ToString()
}
# .
