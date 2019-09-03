Function New-ZertoVPGVMRecovery {
    [CmdletBinding(DefaultParameterSetName = 'Individual')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DatastoreClusterIdentifier')] [string] $DatastoreClusterIdentifier , 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DatastoreIdentifier')] [string] $DatastoreIdentifier , 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'FolderIdentifier')] [string] $FolderIdentifier , 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'HostClusterIdentifier')] [string] $HostClusterIdentifier , 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'HostIdentifier')] [string] $HostIdentifier , 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'ResourcePoolIdentifier')] [string] $ResourcePoolIdentifier , 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGVMRecovery ')] [PSCustomObject] $VPGVMRecovery 
    )
    
    if (-not $VPGVMRecovery) {
        [VPGVMRecovery] $NewObj = [VPGVMRecovery]::New( $DatastoreClusterIdentifier, $DatastoreIdentifier, $FolderIdentifier, `
                $HostClusterIdentifier, $HostIdentifier, $ResourcePoolIdentifier);

    }
    else {
        [VPGVMRecovery] $NewObj = [VPGVMRecovery]::New($VPGVMRecovery)
    }

    Return $NewObj
}