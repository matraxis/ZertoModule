Function New-ZertoVPGSettingVMNicNetworkHypervisorIpConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'IsDHCP')] [bool] $IsDhcp = $false,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'StaticIp')] [string] $StaticIp,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'SubnetMask')] [string] $SubnetMask,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Gateway')] [string] $Gateway,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'PrimaryDNS')] [string] $PrimaryDNS,
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'SecondaryDns')] [string] $SecondaryDns,
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting VM NIC Network object')] [PSCustomObject] $VPGSettingVMNicNetworkHypervisorIpConfig
    )

    if (-not $VPGSettingVMNicNetworkHypervisorIpConfig) {
        [ZertoVPGSettingVMNicNetworkHypervisorIpConfig] $NewObj = [ZertoVPGSettingVMNicNetworkHypervisorIpConfig]::New( $Gateway,
            $IsDhcp, 
            $PrimaryDns,
            $SecondaryDns,
            $StaticIp,
            $SubnetMask );
    }
    else {
        [ZertoVPGSettingVMNicNetworkHypervisorIpConfig] $NewObj = [ZertoVPGSettingVMNicNetworkHypervisorIpConfig]::New($VPGSettingVMNicNetworkHypervisorIpConfig)
    }

    Return $NewObj
}  