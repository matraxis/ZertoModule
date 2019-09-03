Function New-ZertoVPGSettingVMNicNetworkHypervisor {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'DNS Suffix')] [string] $DnsSuffix, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPGSetting VM NIC Network Hypervisor IpConfig object')] [ZertoVPGSettingVMNicNetworkHypervisorIpConfig] $IpConfig, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPGSetting VM NIC Network ID')] [string] $NetworkIdentifier,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Should Replace MacAddress')] [bool] $ShouldReplaceMacAddress, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM NIC Network object')] [PSCustomObject] $VPGSettingVMNicNetworkHypervisor
    )

    if (-not $VPGSettingVMNicNetworkHypervisor) {
        [ZertoVPGSettingVMNicNetworkHypervisor] $NewObj = [ZertoVPGSettingVMNicNetworkHypervisor]::New($Hypervisor);
    }
    else {
        [ZertoVPGSettingVMNicNetworkHypervisor] $NewObj = [ZertoVPGSettingVMNicNetworkHypervisor]::New($VPGSettingVMNicNetwork)
    }

    Return $NewObj
}