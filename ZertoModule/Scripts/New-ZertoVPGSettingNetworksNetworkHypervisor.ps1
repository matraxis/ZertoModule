Function New-ZertoVPGSettingNetworksNetworkHypervisor {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DefaultNetworkIdentifier')]   [string] $DefaultNetworkIdentifier = $null,
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Networking Network Hypervisor object')] [PSCustomObject] $VPGSettingNetworkingNetworkHypervisor
    )
    
    if (-not $VPGSettingNetworkingNetworkHypervisor) {
        [ZertoVPGSettingNetworksNetworkHypervisor] $NewObj = [ZertoVPGSettingNetworksNetworkHypervisor]::New($DefaultNetworkIdentifier);
    }
    else {
        [ZertoVPGSettingNetworksNetworkHypervisor] $NewObj = [ZertoVPGSettingNetworksNetworkHypervisor]::New($VPGSettingNetworkingNetworkHypervisor)
    }

    Return $NewObj
}