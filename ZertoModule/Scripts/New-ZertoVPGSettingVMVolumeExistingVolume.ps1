Function New-ZertoVPGSettingVMVolumeExistingVolume {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'DatastoreIdentifier')] [string] $DatastoreIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'ExistingVmIdentifier')] [string] $ExistingVmIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Mode')] [string] $Mode, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Path')] [string] $Path, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM existing Volume object')] [PSCustomObject] $VPGSettingVMVolumeExistingVolume
    )

    if (-not $VPGSettingVMVolumeExistingVolume) {
        [ZertoVPGSettingVMVolumeExistingVolume] $NewObj = [ZertoVPGSettingVMVolumeExistingVolume]::New($DatastoreIdentifier,
            $ExistingVmIdentifier,
            $Mode,
            $Path);
    }
    else {
        [ZertoVPGSettingVMVolumeExistingVolume] $NewObj = [ZertoVPGSettingVMVolumeExistingVolume]::New($VPGSettingVMVolumeExistingVolume)
    }

    Return $NewObj
}