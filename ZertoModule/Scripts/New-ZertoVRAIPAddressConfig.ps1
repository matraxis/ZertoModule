Function New-ZertoVRAIPAddressConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'IP Address')]           [String] $IPAddress,
        [Parameter(Mandatory = $true, HelpMessage = 'Subnet Mask')]          [String] $SubnetMask,
        [Parameter(Mandatory = $true, HelpMessage = 'Gateway')]              [String] $Gateway,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VRA IP Config Type')] [ZertoVRAIPConfigType] $VRAIPType
    )
    
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
        throw "Invalid SubnetMask '$SubnetMask'"
    }
    try {
        $TestIP = [IPAddress]$Gateway  
    }
    catch {
        throw "Invalid Gateway '$Gateway'"
    }

    [VRAIPAddressConfig] $NewVRAIPAddressConfig = [VRAIPAddressConfig]::new( $IPAddress, $SubnetMask, $Gateway, $VRAIPType);
    Return $NewVRAIPAddressConfig    
}