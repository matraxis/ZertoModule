Function New-ZertoVPGSettingBootGroupsBootGroups {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'BootDelayInSeconds')] [int] $BootDelayInSeconds, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Zerto Boot Group Identifier')] [string] $BootGroupIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Zerto Boot Group Name')] [string] $Name, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Bootgroups Bootgroups')] [PSCustomObject] $VPGSettingBootgroupsBootGroups
    )
    
    if (-not $VPGSettingBootgroupsBootgroups) {
        if ( $BootDelayInSeconds -lt 1 ) {
            throw "BootDelayInSeconds must be greather then 0 - '$BootDelayInSeconds'"
        }
        [ZertoVPGSettingBootGroupsBootGroups] $NewObj = [ZertoVPGSettingBootGroupsBootGroups]::New($BootDelayInSeconds, $BootGroupIdentifier, $Name );
    }
    else {
        if ( $VPGSettingBootgroup.BootDelayInSeconds -lt 1 ) {
            throw "BootDelayInSeconds must be greather then 0 - '$VPGSettingBootgroup.BootDelayInSeconds'"
        }
        [ZertoVPGSettingBootGroupsBootGroups] $NewObj = [ZertoVPGSettingBootGroupsBootGroups]::New($VPGSettingBootgroupsBootGroups)
    }

    Return $NewObj
}