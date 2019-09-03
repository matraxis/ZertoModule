Function New-ZertoVPGSettingVM {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'BootGroup Identifier')] [string] $BootGroupIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Array of VPG Setting VM Nic objects')] [ZertoVPGSettingVMNic[]] $Nics, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPG Setting VM Recovery object')] [ZertoVPGSettingVMRecovery] $Recovery, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VM Identifier')] [string] $VmIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Array of VPG Setting VM Volume objects')] [ZertoVPGSettingVMVolume[]] $Volumes, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM Object')] [PSCustomObject] $VPGSettingVM
    )
    
    if (-not $VPGSettingVM) {
        #Check for bad values
        [ZertoVPGSettingVM] $NewObj = [ZertoVPGSettingVM]::New($BootGroupIdentifier, $Journal, $NICs, $Recovery, $VmIdentifier, $Volumes);
    }
    else {
        [ZertoVPGSettingVM] $NewObj = [ZertoVPGSettingVM]::New($VPGSettingVM)
    }

    Return $NewObj
}