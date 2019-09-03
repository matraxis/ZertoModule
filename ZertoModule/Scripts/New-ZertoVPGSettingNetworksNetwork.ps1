Function New-ZertoVPGSettingNetworksNetwork {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Hypervisor')] [ZertoVPGSettingNetworksNetworkHypervisor] $Hypervisor,
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'ZertoVPGSettingNetworksNetworkHypervisor object')] [PSCustomObject] $VPGSettingNetworksNetwork
    )
    
    if (-not $VPGSettingNetworksNetwork) {
        [ZertoVPGSettingNetworksNetwork] $NewObj = [ZertoVPGSettingNetworksNetwork]::New($Hypervisor);
    }
    else {
        [ZertoVPGSettingNetworksNetwork] $NewObj = [ZertoVPGSettingNetworksNetwork]::New($VPGSettingNetworksNetwork)
    }

    Return $NewObj
}