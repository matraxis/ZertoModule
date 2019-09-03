Function New-ZertoVPGSettingVMVolumeDatastore {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'IsSwap')] [bool] $IsThin, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'DatastoreClusterIdentifier')] [string] $DatastoreClusterIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'DatastoreIdentifier')] [string] $DatastoreIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM Volume Datastore object')] [PSCustomObject] $VPGSettingVMVolumeDatastore
    )

    if (-not $VPGSettingVMVolumeDatastore) {
        [ZertoVPGSettingVMVolumeDatastore] $NewObj = [ZertoVPGSettingVMVolumeDatastore]::New($IsThin,
            $DatastoreClusterIdentifier,
            $DatastoreIdentifier);
    }
    else {
        [ZertoVPGSettingVMVolumeDatastore] $NewObj = [ZertoVPGSettingVMVolumeDatastore]::New($VPGSettingVMVolumeDatastore)
    }

    Return $NewObj
}