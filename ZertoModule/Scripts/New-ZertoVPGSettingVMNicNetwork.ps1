Function New-ZertoVPGSettingVMNicNetwork {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPGSetting VM NIC Network Hypervisor')] [ZertoVPGSettingVMNicNetworkHypervisor] $Hypervisor, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM NIC Network object')] [PSCustomObject] $VPGSettingVMNicNetwork
    )

    if (-not $VPGSettingVMNicNetwork) {
        [ZertoVPGSettingVMNicNetwork] $NewObj = [ZertoVPGSettingVMNicNetwork]::New($Hypervisor);
    }
    else {
        [ZertoVPGSettingVMNicNetwork] $NewObj = [ZertoVPGSettingVMNicNetwork]::New($VPGSettingVMNicNetwork)
    }

    Return $NewObj
} 