Function New-ZertoVPGSettingScripting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'PostBackup script object')] [ZertoVPGSettingScript] $PostBackup, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'PostRecovery script object')] [ZertoVPGSettingScript] $PostRecovery, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'PreRecovery script object')] [ZertoVPGSettingScript] $PreRecovery, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Scripting')] [PSCustomObject] $VPGSettingScripting
    )
    
    if (-not $VPGSettingScripting) {
        #Reset Null scripts
        if ($PostRecovery -eq $null) {
            $PostRecovery = New-ZertoVPGSettingScript -Command $null -Parameters $null 
        }
        if ($PreRecovery -eq $null) {
            $PreRecovery = New-ZertoVPGSettingScript -Command $null -Parameters $null 
        }
        [ZertoVPGSettingScripting] $NewObj = [ZertoVPGSettingScripting]::New($PostBackupCommand, $PostRecovery, $PreRecovery);
    }
    else {
        if ($VPGSettingScripting.PostRecovery -eq $null) {
            $VPGSettingScripting.PostRecovery = New-ZertoVPGSettingScript -Command $null -Parameters $null 
        }
        if ($VPGSettingScripting.PreRecovery -eq $null) {
            $VPGSettingScripting.PreRecovery = New-ZertoVPGSettingScript -Command $null -Parameters $null 
        }
        [ZertoVPGSettingScripting] $NewObj = [ZertoVPGSettingScripting]::New($VPGSettingScripting)
    }

    Return $NewObj
}