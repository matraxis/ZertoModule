Function New-ZertoVPGSetting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'VPG Settings Backup  object')] [ZertoVPGSettingBackup] $Backup, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPG Settings Basics  object')] [ZertoVPGSettingBasic] $Basic, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Array of VPG Settings BootGroups  objects')] [ZertoVPGSettingBootGroups[]] $BootGroups, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPG Settings Journal object')] [ZertoVPGSettingJournal] $Journal,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPG Settings Networks object')] [ZertoVPGSettingNetworks] $Networks, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPG Settings Recovery object')] [ZertoVPGSettingRecovery] $Recovery, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'VPG Settings Scripting object')] [ZertoVPGSettingNetworks] $Scripting, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Array of VPG Settings Vms objects')] [ZertoVPGSettingVM[]] $Vms, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'VPG Settings VPG Identifier')] [string] $VpgIdentifier, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'VPG Settings VPG Settings Identifier')] [string] $VpgSettingsIdentifierVms, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM Object')] [PSCustomObject] $VPGSetting
    )

    if (-not $VPGSetting) {
        #Check for bad values
        [ZertoVPGSetting] $NewObj = [ZertoVPGSetting]::New($Backup, $Basic, $BootGroups, $Journal, $Networks, $Recovery, $Scripting, `
                $Vms, $VpgIdentifier, $VpgSettingsIdentifierVms );
    }
    else {
        [ZertoVPGSetting] $NewObj = [ZertoVPGSetting]::New($VPGSetting)
    }

    Return $NewObj
}