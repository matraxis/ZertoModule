Function New-ZertoVPGSettingBootGroups {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'ZertoVPGSettingBootgroup')] [ZertoVPGSettingBootGroups[]] $BootGroups,
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Bootgroup')] [PSCustomObject] $VPGSettingBootGroups
    )
    
    if (-not $VPGSettingBootGroups) {
        [ZertoVPGSettingBootGroups] $NewObj = [ZertoVPGSettingBootGroups]::New( $Bootgroups );
    }
    else {
        [ZertoVPGSettingBootGroups] $NewObj = [ZertoVPGSettingBootGroups]::New($VPGSettingBootGroups)
    }

    Return $NewObj
}