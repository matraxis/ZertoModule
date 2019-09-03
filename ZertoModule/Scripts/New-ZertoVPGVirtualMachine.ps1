Function New-ZertoVPGVirtualMachine {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VM Name')]     [String] $VMName,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto IPAddresses')]  [VPGFailoverIPAddress[]] $VPGFailoverIPAddress,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto VM Recovery Object')]  [VPGVMRecovery] $VPGVMRecovery
        #Add other optional vpg components here
    )
    
    [VPGVirtualMachine] $NewZertoVM = [VPGVirtualMachine]::New($VMName);

    if ($VPGFailoverIPAddress) {
        $NewZertoVM.AddVPGFailoverIPAddress($VPGFailoverIPAddress)
    }
    if ($VPGVMRecovery) {
        $NewZertoVM.AddVPGVMRecovery($VPGVMRecovery)
    }
    #Add other optional vpg components Add's here

    Return $NewZertoVM    
}