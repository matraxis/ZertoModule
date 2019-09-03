Function New-ZertoVPGSettingVMVolume {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'IsSwap')] [bool] $IsSwap, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VolumeIdentifier')] [string] $VolumeIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'ZertoVPGSettingVMVolumeDatastore')] [string] $Datastore, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'ZertoVPGSettingVMVolumeExistingVolume')] [string] $ExistingVolume, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPG Setting VM Volume object')] [PSCustomObject] $VPGSettingVMVolume
    )

    if (-not $VPGSettingVMVolume) {
        [ZertoVPGSettingVMVolume] $NewObj = [ZertoVPGSettingVMVolume]::New($IsSwap,
            $VolumeIdentifier,
            $Datastore,
            $ExistingVolume);
    }
    else {
        [ZertoVPGSettingVMVolume] $NewObj = [ZertoVPGSettingVMVolume]::New($VPGSettingVMVolume)
    }

    Return $NewObj
}