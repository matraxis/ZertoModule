Function New-ZertoVPGSettingNetworks {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Network Failover object')] [ZertoVPGSettingNetworksNetwork] $Failover, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Network FailoverTest object')] [ZertoVPGSettingNetworksNetwork] $FailoverTest, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Network')] [PSCustomObject] $VPGSettingNetworks
    )
    
    if (-not $VPGSettingNetworks) {
        #Reset Null Networks
        if ($Failover -eq $null) {
            $Failover = New-ZertoVPGSettingNetworkHypervisor -DefaultNetworkIdentifier $null 
        }
        if ($FailoverTest -eq $null) {
            $FailoverTest = New-ZertoVPGSettingNetworkHypervisor -DefaultNetworkIdentifier $null 
        }
        [ZertoVPGSettingNetworks] $NewObj = [ZertoVPGSettingNetworks]::New($Failover, $FailoverTest);
    }
    else {
        if ($VPGSettingNetworks.Failover -eq $null) {
            $VPGSettingNetworks.Failover = New-ZertoVPGSettingNetworkHypervisor -DefaultNetworkIdentifier $null 
        }
        if ($VPGSettingNetworks.FailoverTest -eq $null) {
            $VPGSettingNetworks.FailoverTest = New-ZertoVPGSettingNetworkHypervisor -DefaultNetworkIdentifier $null 
        }
        [ZertoVPGSettingNetworks] $NewObj = [ZertoVPGSettingNetworks]::New($VPGSettingNetworks)
    }

    Return $NewObj
}