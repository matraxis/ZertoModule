Function New-ZertoVPGFailoverIPAddress {
    #Parameter Sets
    # Default NICName Req, NetworkID,  ReplaceMAC, TestNetworkID TestReplaceMAC Optional
    #  1) DHCP req, FailDHCP optional
    #  3) IPaddress, Submet, Gateway, DNS1, DN2, DNSSUfix req, Test versions opt
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'vCenter NIC Name')]          [String] $NICName,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Network ID')]         [String] $NetworkID,
        [Parameter(Mandatory = $false, HelpMessage = 'Replace MAC Address')]      [Bool]   $ReplaceMAC = $false,
        [Parameter(Mandatory = $false, HelpMessage = 'Test Zerto Network ID')]    [String] $TestNetworkID,
        [Parameter(Mandatory = $false, HelpMessage = 'Test Replace MAC Address')] [Bool]   $TestReplaceMAC = $false,
        [Parameter(Mandatory = $true, HelpMessage = 'DNS Domain Suffix')]         [String] $DNSSuffix,
        [Parameter(Mandatory = $false, HelpMessage = 'Test DNS Domain Suffix')]   [String] $TestDNSSuffix,

        [Parameter(Mandatory = $true, HelpMessage = 'Use DHCP', ParameterSetName = 'DHCP')]           [switch] $UseDHCP,
        [Parameter(Mandatory = $false, HelpMessage = 'Use DHCP for test', ParameterSetName = 'DHCP')] [switch] $TestUseDHCP,

        [Parameter(Mandatory = $true, HelpMessage = 'IP Address', ParameterSetName = 'IP')]           [String] $IPAddress,
        [Parameter(Mandatory = $true, HelpMessage = 'Subnet Mask', ParameterSetName = 'IP')]          [String] $SubnetMask,
        [Parameter(Mandatory = $true, HelpMessage = 'Gateway', ParameterSetName = 'IP')]              [String] $Gateway,
        [Parameter(Mandatory = $true, HelpMessage = 'DNS Server 1', ParameterSetName = 'IP')]         [String] $DNS1,
        [Parameter(Mandatory = $true, HelpMessage = 'DNS Server 2', ParameterSetName = 'IP')]         [String] $DNS2,
        [Parameter(Mandatory = $false, HelpMessage = 'Test IP Address', ParameterSetName = 'IP')]     [String] $TestIPAddress,
        [Parameter(Mandatory = $false, HelpMessage = 'Test Subnet Mask', ParameterSetName = 'IP')]    [String] $TestSubnetMask,
        [Parameter(Mandatory = $false, HelpMessage = 'Test Gateway', ParameterSetName = 'IP')]        [String] $TestGateway,
        [Parameter(Mandatory = $false, HelpMessage = 'Test DNS Server 1', ParameterSetName = 'IP')]   [String] $TestDNS1,
        [Parameter(Mandatory = $false, HelpMessage = 'Test DNS Server 2', ParameterSetName = 'IP')]   [String] $TestDNS2
    )
    
    Write-Verbose $PSCmdlet.ParameterSetName
    If ($PSCmdlet.ParameterSetName -eq 'DHCP') {
        if (-not $UseDHCP) {
            throw "If UseDHCP is false, IP addresses must be specified" 
        }
        [VPGFailoverIPAddress] $NewZertoIP = [VPGFailoverIPAddress]::new( $NICName, $NetworkID, $ReplaceMAC, $UseDHCP, $DNSSuffix, `
                $TestNetworkID, $TestReplaceMAC, $TestUseDHCP, $TestDNSSuffix);
    }
    else {
        try {
            $TestIP = [IPAddress]$IPAddress  
        }
        catch {
            throw "Invalid IP Address '$IPAddress'"
        }
        try {
            $TestIP = [IPAddress]$SubnetMask 
        }
        catch {
            throw "Invalid Subnet Mask '$SubnetMask'"
        }
        try {
            $TestIP = [IPAddress]$Gateway    
        }
        catch {
            throw "Invalid Gateway '$Gateway'"
        }
        try {
            $TestIP = [IPAddress]$DNS1       
        }
        catch {
            throw "Invalid DNS1 '$DNS1'"
        }
        try {
            $TestIP = [IPAddress]$DNS2       
        }
        catch {
            throw "Invalid DNS2 '$DNS2'"
        }
        try {
            if ($TestIPAddress) {
                $TestIP = [IPAddress]$TestIPAddress 
            }  
        }
        catch {
            throw "Invalid Test IP Address '$TestPAddress'"
        }
        try {
            if ($TestSubnetMask) {
                $TestIP = [IPAddress]$TestSubnetMask 
            } 
        }
        catch {
            throw "Invalid Test Subnet Mask '$TestSubnetMask'"
        }
        try {
            if ($TestGateway) {
                $TestIP = [IPAddress]$TestGateway 
            }    
        }
        catch {
            throw "Invalid Test Gateway '$TestGateway'"
        }
        try {
            if ($TestDNS1) {
                $TestIP = [IPAddress]$TestDNS1 
            }       
        }
        catch {
            throw "Invalid Test DNS1 '$TestDNS1'"
        }
        try {
            if ($TestDNS2) {
                $TestIP = [IPAddress]$TestDNS2 
            }       
        }
        catch {
            throw "Invalid Test DNS2 '$TestDNS2'"
        }

        [VPGFailoverIPAddress] $NewZertoIP = [VPGFailoverIPAddress]::new( $NICName, $NetworkID, $ReplaceMAC, $IPAddress, `
                $SubnetMask, $Gateway, $DNS1, $DNS2, $DNSSuffix, $TestNetworkID, $TestReplaceMAC, `
                $TestIPAddress, $TestSubnetMask, $TestGateway, $TestDNS1, $TestDNS2, $TestDNSSuffix);
    }
    Return $NewZertoIP    
}