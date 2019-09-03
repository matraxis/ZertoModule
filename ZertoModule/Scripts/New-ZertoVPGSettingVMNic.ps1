Function New-ZertoVPGSettingVMNic {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Nic Identifier')] [string] $NicIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VM Failover Network')] [ZertoVPGSettingVMNicNetwork] $VMNetworkFailover, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VM Test Network')] [ZertoVPGSettingVMNicNetwork] $VMNetworkTest, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM NIC object')] [PSCustomObject] $VPGSettingVMNic
    )

    if (-not $VPGSettingVMNic) {
        [ZertoVPGSettingVMNic] $NewObj = [ZertoVPGSettingVMNic]::New($NicIdentifier, $ParaVMNetworkFailovermeters, $VMNetworkTest);
    }
    else {
        [ZertoVPGSettingVMNic] $NewObj = [ZertoVPGSettingVMNic]::New($VPGSettingVMNic)
    }

    Return $NewObj
}