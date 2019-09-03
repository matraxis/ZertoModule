Function New-ZertoVPGSettingVMRecovery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DatastoreClusterIdentifier')] [string] $DatastoreClusterIdentifier = $null, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DatastoreIdentifier')] [string] $DatastoreIdentifier = $null, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'FolderIdentifier')] [string] $FolderIdentifier = $null,
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'HostClusterIdentifier')] [string] $HostClusterIdentifier = $null, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'HostIdentifier')] [string] $HostIdentifier = $null, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'ResourcePoolIdentifier')] [string] $ResourcePoolIdentifier = $null, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM Recovery object')] [PSCustomObject] $VPGSettingVMRecovery
    )

    if (-not $VPGSettingVMRecovery) {
        [ZertoVPGSettingVMRecovery] $NewObj = [ZertoVPGSettingVMRecovery]::New($DatastoreClusterIdentifier,
            $DatastoreIdentifier,
            $FolderIdentifier,
            $HostClusterIdentifier,
            $HostIdentifier,
            $ResourcePoolIdentifier);
    }
    else {
        [ZertoVPGSettingVMRecovery] $NewObj = [ZertoVPGSettingVMRecovery]::New($VPGSettingVMRecovery)
    }

    Return $NewObj
}