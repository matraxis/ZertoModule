Function Add-VMtoZertoVPG {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Name')] [string] $VPGName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto VPG Priority')] [ZertoVPGPriority] $Priority = 'Medium',
        #[Parameter(Mandatory = $true, HelpMessage = 'Zerto Recovery Site Name')] [string] $RecoverySiteName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto RPO Alert in seconds')] [ValidateRange(0, 99999)]  [int] $RPOAlertInSeconds = 300,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto Test Interval in minutes')] [ValidateRange(0, 9999999)] [int] $TestIntervalInMinutes = 262080,
        #[Parameter(Mandatory = $false, HelpMessage = 'Host Cluster Name')] [string] $ClusterName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Host Name')] [string] $HostName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Failover Network')] [string] $FailoverNetwork,
        #[Parameter(Mandatory = $false, HelpMessage = 'Failover Network ID')] [string] $FailoverNetworkID,
        #[Parameter(Mandatory = $false, HelpMessage = 'Test Network')] [string] $TestNetwork,
        #[Parameter(Mandatory = $false, HelpMessage = 'Test Network ID')] [string] $TestNetworkID,
        #[Parameter(Mandatory = $false, HelpMessage = 'Datastore Name')] [string] $DatastoreName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Datastore Cluster Name')] [string] $DatastoreClusterName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Use Default for Journal Datastore')] [switch] $JournalUseDefault,
        #[Parameter(Mandatory = $false, HelpMessage = 'Journal Datastore Name')] [string] $JournalDatastoreName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Journal Datastore Cluster Name')] [string] $JournalDatastoreClusterName,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto Journal History In Hours')] [ValidateRange(0, 9999)] [int] $JournalHistoryInHours = 24,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto Journal Hard Limit in MB')] [ValidateRange(0, 9999999)] [int] $JournalHardLimitMB = 153600,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto Journal Warning Threshold in MB')] [ValidateRange(0, 9999999)] [int] $JournalWarningThresholdMB = 115200,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto vCenter Folder')] [string] $Folder,
        #[Parameter(Mandatory = $false, HelpMessage = 'Zerto vCenter Folder ID')] [string] $FolderID,
        [Parameter(Mandatory = $true, ParameterSetName = "VMNames", HelpMessage = 'Zerto Virtual Machine names')] [string[]] $VmNames,
        [Parameter(Mandatory = $true, ParameterSetName = "VMClass", HelpMessage = 'Zerto VPG Virtual Machine class')] [VPGVirtualMachine[]] $VPGVirtualMachines
        , [Parameter(Mandatory = $false, HelpMessage = 'Commit this Zerto VPG')] [bool] $VPGCommit = $true
        , [Parameter(Mandatory = $false, HelpMessage = 'Dump Json without posting for debug')] [switch] $DumpJson
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($VPGName)  ) {
        throw "Missing Zerto VPG Name" 
    }
 <#
    if ([string]::IsNullOrEmpty($Priority)  ) {
        throw "Missing Zerto Priority" 
    }
    #Validate Parameter Sets
    if ($FailoverNetwork -and $FailoverNetworkID) {
        throw "Cannot specify both Failover Network and Failover Network ID"
    }
    if (-not $FailoverNetwork -and -not $FailoverNetworkID) {
        throw "Must specify either Failover Network or Failover Network ID"
    }
    if ($TestNetwork -and $TestNetworkID) {
        throw "Cannot specify both Test Network and Test Network ID"
    }
    if (-not $TestNetwork -and -not $TestNetworkID) {
        throw "Must specify either Test Network or Test Network ID"
    }
    if ($HostName -and $ClusterName) {
        throw "Cannot specify both Host Name and Cluster Name"
    }
    if (-not $HostName -and -not $ClusterName) {
        throw "Must specify either Host Name or Cluster Name"
    }
    if ($DatastoreName -and $DatastoreClusterName) {
        throw "Cannot specify both Datastore Name and Datastore Cluster Name"
    }
    if (-not $DatastoreName -and -not $DatastoreclusterName) {
        throw "Must specify either Datastore Name or Datastore Cluster Name"
    }
    if ($JournalUseDefault -and ($JournalDatastoreName -OR $JournalDatastoreclusterName ) ) {
        throw "Cannot specify JournalUseDefault and JournalDatastoreName or JournalDatastoreClusterName"
    }
    if ((-not $JournalUseDefault ) -and ($JournalDatastoreName -AND $JournalDatastoreclusterName) ) {
        throw "Cannot specify both JournalDatastoreName and JournalDatastoreClusterName"
    }
    if ((-not $JournalUseDefault ) -and (-not $JournalDatastoreName -and -not $JournalDatastoreclusterName)) {
        throw "Must specify either Journal Datastore Name or Journal Datastore Cluster Name"
    }
    if ($Folder -and $FolderID) {
        throw "Cannot specify both Folder and Folder ID"
    }
    if (-not $Folder -and -not $FolderID) {
        throw "Must specify either Folder or Folder ID"
    }
    ### Temp validation
    #If ($DatastoreClusterName)  {throw "Cannot specify DatastoreClusterName as a default value for the VPG (bug in zerto 5.0)"}
  #>
    if ( $VmNames.Count -lt 1 -and $VPGVirtualMachines.Count -lt 1 ) {
        throw "Must specify at least one VmName or VPGVirtualMachine"
    }
    #Get Identifiers
  
    $LocalSiteID = Get-ZertoLocalSiteID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken
    if ([string]::IsNullOrEmpty($LocalSiteID)  ) {
        throw "Could not find Local Site ID" 
    }
  <#
    $RecoverySiteID = Get-ZertoVirtualizationSiteID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
        -ZertoSiteName $RecoverySiteName
    if ([string]::IsNullOrEmpty($RecoverySiteID)  ) {
        throw "Could not find Recovery Site ID for $RecoverySiteName " 
    }
    #Get FailoverNeworkID if not specified
    if ($FailoverNetwork ) {
        $FailoverNetworkID = Get-ZertoSiteNetworkID -ZertoServer $ZertoServer -ZertoPort $ZertoPort  -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -NetworkName $FailoverNetwork
        if ([string]::IsNullOrEmpty($FailoverNetworkID)  ) {
            throw "Could not find Failover Network ID for $FailoverNetwork " 
        }
        if ( $FailoverNetworkID.Count -gt 1 ) {
            throw "More than one Failover Network ID has the name $FailoverNetwork " 
        }
    }
    #Get FailoverNeworkID if not specified
    if ($TestNetwork ) {
        $TestNetworkID = Get-ZertoSiteNetworkID -ZertoServer $ZertoServer -ZertoPort $ZertoPort  -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -NetworkName $TestNetwork
        if ([string]::IsNullOrEmpty($TestNetworkID)  ) {
            throw "Could not find Test Network ID for $TestNetwork " 
        }
        if ( $TestNetworkID.Count -gt 1 ) {
            throw "More than one Test Network ID has the name $TestNetwork " 
        }
    }
    if ($ClusterName) {
        $ClusterID = Get-ZertoSiteHostClusterID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -HostClusterName $ClusterName
        if ([string]::IsNullOrEmpty($ClusterID)  ) {
            throw "Could not find Cluster ID for $ClusterName " 
        }
        $HostID = $null
    }
    elseif ($HostName) {
        $ClusterID = $null
        $HostID = Get-ZertoSiteHostID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -HostName $HostName
        if ([string]::IsNullOrEmpty($HostID)  ) {
            throw "Could not find Host ID for $HostName " 
        }
    }
    #BROKEN
    #$ServiceProfileID = Get-ZertoServiceProfile -ZertoToken $ZertoToken  | `
    #
    Where-Object { $_.Description -eq $ServiceProfile } | `
        #
    Select-Object SiteIdentifier -ExpandProperty SiteIdentifier
    if ($DatastoreName) {
        $DatastoreID = Get-ZertoSiteDatastoreID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -DatastoreName $DatastoreName
        if ([string]::IsNullOrEmpty($DatastoreID)  ) {
            throw "Could not find Datastore ID for $DatastoreName " 
        }
        $DatastoreClusterID = $null
    }
    elseif ($DatastoreClusterName) {
        $DatastoreID = $null
        $DatastoreClusterID = Get-ZertoSiteDatastoreClusterID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -DatastoreClusterName $DatastoreclusterName
        if ([string]::IsNullOrEmpty($DatastoreClusterID)  ) {
            throw "Could not find Datastore Cluster ID for $DatastoreclusterName " 
        }
    }
    if (-NOT $JournalUseDefault) {
        if ($JournalDatastoreName) {
            $JournalDatastoreID = Get-ZertoSiteDatastoreID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
                -ZertoSiteIdentifier $RecoverySiteID -DatastoreName  $JournalDatastoreName
            $JournalDatastoreClusterID = $null
            if ([string]::IsNullOrEmpty($JournalDatastoreID)  ) {
                throw "Could not find Datastore ID for $JournalDatastoreName " 
            }
        }
        elseif ($JournalDatastoreClusterName) {
            $JournalDatastoreID = $null
            $JournalDatastoreClusterID = Get-ZertoSiteDatastoreClusterID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
                -ZertoSiteIdentifier $RecoverySiteID -DatastoreClusterName  $JournalDatastoreClusterName
            if ([string]::IsNullOrEmpty($JournalDatastoreClusterID)  ) {
                throw "Could not find Datastore Cluster ID for $JournalDatastoreclusterName " 
            }
        }
    }
    #Get FailoverNeworkID if not specified
    if ($Folder ) {
        $FolderID = Get-ZertoSiteFolderID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
            -ZertoSiteIdentifier $RecoverySiteID -FolderName $Folder
        if ([string]::IsNullOrEmpty($FolderID)  ) {
            throw "Could not find Folder ID for $Folder " 
        }
        if ( $FolderID.Count -gt 1 ) {
            throw "More than one Folder ID has the name $Folder " 
        }
    }
#>

    #Save our VMID in a VMName/ID Hash
    $VMNameAndIDHash = [ordered] @{ }
    if ($VmNames) {
        $VmNames | ForEach-Object {
            #VM's are always from LocalSite
            $VMID = Get-ZertoSiteVMID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
                -ZertoSiteIdentifier $LocalSiteID -VMName $_
            $VMNameAndIDHash.Add($_, $VMID)
        }
    }
    elseif ($VPGVirtualMachines) {
        $VPGVirtualMachines | ForEach-Object {
            #VM's are always from LocalSite
            $VMID = Get-ZertoSiteVMID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken `
                -ZertoSiteIdentifier $LocalSiteID -VMName $_.VMName
            $VMNameAndIDHash.Add($_.VMName , $VMID)
        }
    }
    else {
        throw "No VM's specified"
    }

   <# 
    if ( $RecoverySiteID.Count -gt 1 ) {
        throw "More than one Recovery site has the name $RecoverySiteName " 
    }
    if ($ClusterName) {
        if ( $ClusterID.Count -gt 1 ) {
            throw "More than one Cluster ID has the name $ClusterName " 
        }
    }
    elseif ($HostName) {
        if ( $HostID.Count -gt 1 ) {
            throw "More than one Host ID has the name $HostName  " 
        }
    }
    if ($DatastoreName) {
        if ( $DatastoreID.Count -gt 1 ) {
            throw "More than one Datastore ID has the name $DatastoreName " 
        }
    }
    elseif ($DatastoreClusterName) {
        if ( $DatastoreClusterID.Count -gt 1 ) {
            throw "More than one Datastore Cluster ID has the name $DatastoreclusterName " 
        }
    }
    if (-NOT $JournalUseDefault) {
        if ($JournalDatastoreName) {
            if ( $JournalDatastoreID.Count -gt 1 ) {
                throw "More than one Datastore ID has the name $JournalDatastoreName " 
            }
        }
        elseif ($JournalDatastoreClusterName) {
            if ( $JournalDatastoreClusterID.Count -gt 1 ) {
                throw "More than one Datastore Cluster ID has the name $JournalDatastoreclusterName " 
            }
        }
    }
    #>
    #Build up our json object
    $NewBodyHash = [ordered] @{ }
<#
    $NewBodyHash.Add('Backup' , $null)
    $Basic = [ordered] @{ }
    $Basic.Add( 'JournalHistoryInHours', $JournalHistoryInHours)
    $Basic.Add( 'Name', $VPGName)
    $Basic.Add( 'Priority', $Priority.ToString() )
    $Basic.Add( 'ProtectedSiteIdentifier', $LocalSiteID)
    $Basic.Add( 'RecoverySiteIdentifier', $RecoverySiteID )
    $Basic.Add( 'RpoInSeconds', $RPOAlertInSeconds)
    $Basic.Add( 'ServiceProfileIdentifier', $null )
    $Basic.Add( 'TestIntervalInMinutes', $TestIntervalInMinutes )
    $Basic.Add( 'UseWanCompression', $true )
    $Basic.Add( 'ZorgIdentifier', $null )
    $NewBodyHash.Add('Basic' , $Basic)
    $BootGroupsItem = [ordered] @{ }
    $BootGroupsItem.Add( 'BootDelayInSeconds', 0)
    $BootGroupsItem.Add( 'BootGroupIdentifier', '00000000-0000-0000-0000-000000000000')
    $BootGroupsItem.Add( 'Name', 'Default')
    $BootGroupsArray = @()
    $BootGroupsArray += $BootGroupsItem
    $BootGroups = @{'BootGroups' = $BootGroupsArray }
    $NewBodyHash.Add('BootGroups' , $BootGroups )
    $Journal = [ordered] @{ }
    if ($JournalUseDefault) {
        #Use the defaults
        #if ($DatastoreID) {
        #$Journal.Add( 'DatastoreClusterIdentifier', $null)
        #$Journal.Add( 'DatastoreIdentifier', $DatastoreID)
        #} else {
        #$Journal.Add( 'DatastoreClusterIdentifier', $DatastoreClusterID)
        #$Journal.Add( 'DatastoreIdentifier', $null)
        #}
        #$Journal.Add( 'DatastoreClusterIdentifier', $null)
        #$Journal.Add( 'DatastoreIdentifier', $null)
    }
    else {
        if ($JournalDatastoreID) {
            $Journal.Add( 'DatastoreClusterIdentifier', $null)
            $Journal.Add( 'DatastoreIdentifier', $JournalDatastoreID)
        }
        else {
            $Journal.Add( 'DatastoreClusterIdentifier', $JournalDatastoreClusterID)
            $Journal.Add( 'DatastoreIdentifier', $null)
        }
    }
    $JournalLimit = [ordered] @{ }
    #This should allow the %, but currently not a parameter
    if ($JournalHardLimitMB -gt 0) {
        $JournalLimit.Add( 'HardLimitInMB', $JournalHardLimitMB )
        $JournalLimit.Add( 'HardLimitInPercent', $null )
    }
    else {
        $JournalLimit.Add( 'HardLimitInMB', $JournalHardLimitMB )
        $JournalLimit.Add( 'HardLimitInPercent', $null )
    }
    $JournalLimit.Add( 'WarningThresholdInMB', $JournalWarningThresholdMB )
    $JournalLimit.Add( 'WarningThresholdInPercent', $null )
    $Journal.Add( 'Limitation', $JournalLimit)
    $NewBodyHash.Add('Journal' , $Journal )
    $Networks = [ordered] @{ }
    $Failover = [ordered] @{ }
    $DefaultNetworkIdentifier = [ordered] @{ }
    $DefaultNetworkIdentifier.Add('DefaultNetworkIdentifier', $FailoverNetworkID)
    $Failover.Add( 'Hypervisor', $DefaultNetworkIdentifier )
    $Networks.Add( 'Failover', $Failover)
    $FailoverTest = [ordered] @{ }
    $DefaultNetworkIdentifier = [ordered] @{ }
    $DefaultNetworkIdentifier.Add('DefaultNetworkIdentifier', $TestNetworkID)
    $FailoverTest.Add( 'Hypervisor', $DefaultNetworkIdentifier )
    $Networks.Add( 'FailoverTest', $FailoverTest)
    $NewBodyHash.Add('Networks' , $Networks )
    $Recovery = [ordered] @{ }
    if ($DatastoreID) {
        #$Recovery.Add( 'DefaultDatastoreClusterIdentifier', $null)
        $Recovery.Add( 'DefaultDatastoreIdentifier', $DatastoreID)
    }
    else {
        #### NOTE THIS IS BROKEN
        #$Recovery.Add( 'DefaultDatastoreClusterIdentifier', $DatastoreClusterID)
        $Recovery.Add( 'DefaultDatastoreClusterIdentifier', $null)
        $Recovery.Add( 'DefaultDatastoreIdentifier', $null)
    }
    $Recovery.Add( 'DefaultFolderIdentifier', $FolderID)
    if ($ClusterID) {
        $Recovery.Add( 'DefaultHostClusterIdentifier', $ClusterID)
        $Recovery.Add( 'DefaultHostIdentifier', $null)
    }
    else {
        $Recovery.Add( 'DefaultHostClusterIdentifier', $null)
        $Recovery.Add( 'DefaultHostIdentifier', $HostID)
    }
    $Recovery.Add( 'ResourcePoolIdentifier', $null)
    $NewBodyHash.Add( 'Recovery' , $Recovery )
    $Scripting = [ordered] @{ }
    $Scripting.Add( 'PostBackup', $null)
    $PostRecovery = [ordered] @{ }
    $PostRecovery.Add( 'Command', $null)
    $PostRecovery.Add( 'Parameters', $null)
    $PostRecovery.Add( 'TimeoutInSeconds', 0)
    $Scripting.Add( 'PostRecovery', $PostRecovery)
    $PreRecovery = [ordered] @{ }
    $PreRecovery.Add( 'Command', $null)
    $PreRecovery.Add( 'Parameters', $null)
    $PreRecovery.Add( 'TimeoutInSeconds', 0)
    $Scripting.Add( 'PreRecovery', $PreRecovery)
    $NewBodyHash.Add( 'Scripting' , $Scripting )
  #>
    $VMArray = @()
    if ($VmNames) {
        #This section is VM + ID only
        if ($VMNameAndIDHash.Keys.Count -gt 0) {
            $VMNameAndIDHash.Keys | ForEach-Object {
                $VMArray += @{ 'VmIdentifier' = $VMNameAndIDHash[$_] }
            }
        }
    }
    elseif ($VPGVirtualMachines) {
        $VPGVirtualMachines | ForEach-Object {
            #region VM Foreach
            $NewVmHash = [ordered] @{ }
            #Lookup ID from $VMNameAndIDHash
            $NewVmHash.Add('VmIdentifier' , $VMNameAndIDHash[$_.VMName] )
            $NewVmHash.Add('BootGroupIdentifier', '00000000-0000-0000-0000-000000000000' )
            #Loop through our NICs
            $AllNics = @()
            $_.VPGFailoverIPAddresses | ForEach-Object {
                $Nic = [ordered] @{ }
                $Nic.Add( "NicIdentifier" , $_.NicName)
                $NicFail = [ordered] @{ }
                $NicFailHyper = [ordered] @{ }
                $NicFailHyper.Add("DnsSuffix", $_.DnsSuffix)
                $NicFailHyperIP = [ordered] @{ }
                if ($_.UseDHCP) {
                    $NicFailHyperIP.Add("Gateway", "")
                    $NicFailHyperIP.Add("IsDhcp", $true)
                    $NicFailHyperIP.Add("PrimaryDns", "")
                    $NicFailHyperIP.Add("SecondaryDns", "")
                    $NicFailHyperIP.Add("StaticIp", "")
                    $NicFailHyperIP.Add("SubnetMask", "")
                }
                else {
                    $NicFailHyperIP.Add("Gateway", $_.Gateway)
                    $NicFailHyperIP.Add("IsDhcp", $false)
                    $NicFailHyperIP.Add("PrimaryDns", $_.Dns1)
                    $NicFailHyperIP.Add("SecondaryDns", $_.Dns2)
                    $NicFailHyperIP.Add("StaticIp", $_.IPAddress)
                    $NicFailHyperIP.Add("SubnetMask", $_.SubnetMask)
                }
                $NicFailHyper.Add("IpConfig", $NicFailHyperIP)
                if ($_.NetworkID) {
                    $NicFailHyper.Add( "NetworkIdentifier" , $_.NetworkID) 
                }
                $NicFailHyper.Add("ShouldReplaceMacAddress" , $_.ReplaceMAC)
                $NicFail.Add( "Hypervisor", $NicFailHyper)
                #Add Failover to NIC
                $Nic.Add("Failover", $NicFail)
                If ($_.TestIPAddress -or $_.TestUseDHCP) {
                    $NicTest = [ordered] @{ }
                    $NicTestHyper = [ordered] @{ }
                    $NicTestHyper.Add("DnsSuffix", $_.TestDnsSuffix)
                    $NicTestHyperIP = [ordered] @{ }
                    if ($_.TestUseDHCP) {
                        $NicTestHyperIP.Add("Gateway", "")
                        $NicTestHyperIP.Add("IsDhcp", $true)
                        $NicTestHyperIP.Add("PrimaryDns", "")
                        $NicTestHyperIP.Add("SecondaryDns", "")
                        $NicTestHyperIP.Add("StaticIp", "")
                        $NicTestHyperIP.Add("SubnetMask", "")
                    }
                    else {
                        $NicTestHyperIP.Add("Gateway", $_.TestGateway)
                        $NicTestHyperIP.Add("IsDhcp", $false)
                        $NicTestHyperIP.Add("PrimaryDns", $_.TestDns1)
                        $NicTestHyperIP.Add("SecondaryDns", $_.TestDns2)
                        $NicTestHyperIP.Add("StaticIp", $_.TestIPAddress)
                        $NicTestHyperIP.Add("SubnetMask", $_.TestSubnetMask)
                    }
                    $NicTestHyper.Add("IpConfig", $NicTestHyperIP)
                    if ($_.TestNetworkID) {
                        $NicTestHyper.Add( "NetworkIdentifier" , $_.TestNetworkID) 
                    }
                    $NicTestHyper.Add( "ShouldReplaceMacAddress" , $_.TestReplaceMAC)
                    $NicTest.Add("Hypervisor", $NicTestHyper)
                    #Add Failover Test to NIC
                    $Nic.Add("FailoverTest", $NicTest)
                }
                $AllNics += $Nic
            }  #end of foreach $_.VPGFailoverIPAddresses
            $NewVmHash.Add('Nics', $AllNics )
            #Add recovery block if needed
            If ($_.VPGVMRecovery) {
                $VMRecovery = [ordered] @{ }
                #Don't send blanks
                if ($_.VPGVMRecovery.DatastoreClusterIdentifier) {
                    $VMRecovery.Add( 'DatastoreClusterIdentifier', $_.VPGVMRecovery.DatastoreClusterIdentifier) 
                }
                if ($_.VPGVMRecovery.DatastoreIdentifier) {
                    $VMRecovery.Add( 'DatastoreIdentifier', $_.VPGVMRecovery.DatastoreIdentifier) 
                }
                if ($_.VPGVMRecovery.FolderIdentifier) {
                    $VMRecovery.Add( 'FolderIdentifier', $_.VPGVMRecovery.FolderIdentifier) 
                }
                if ($_.VPGVMRecovery.HostClusterIdentifier) {
                    $VMRecovery.Add( 'HostClusterIdentifier', $_.VPGVMRecovery.HostClusterIdentifier) 
                }
                if ($_.VPGVMRecovery.HostIdentifier) {
                    $VMRecovery.Add( 'HostIdentifier', $_.VPGVMRecovery.HostIdentifier) 
                }
                if ($_.VPGVMRecovery.ResourcePoolIdentifier) {
                    $VMRecovery.Add( 'ResourcePoolIdentifier', $_.VPGVMRecovery.ResourcePoolIdentifier) 
                }
                $NewVmHash.Add('Recovery', $VMRecovery)
            }
            #Add this VM Hash to the VMArray
            $VMArray += $NewVmHash
            #endregion
        }
    }
    else {
        throw "No VM's specified"
    }

    #Get VPG ID
    $VPGID = Get-ZertoVPGID -VpgName $VPGName
    Write-Verbose $VPGID

    $JSONVPG ="{
    ""VpgIdentifier"":""$VPGID""
    }"
    Write-Verbose $JSONVPG
    
    $FullURL = $baseURL + "vpgsettings"
    Write-Verbose $FullURL

    #Create the VPG settings
    $VPGSettingsID = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Post -Body $JSONVPG
    if ( $VPGSettingsID -eq $null ) {
    throw "Error creating VPG" 
    }
    Write-Verbose ("VPGSettingsID: " + $VPGSettingsID)

    Foreach($VM in $VMArray)
    {
        $NewBodyHash = $VM
        #Convert VPG Hash to JSON - Remember DEPTH!!!
        $NewVMJson = $NewBodyHash | ConvertTo-Json -Depth 20
   
        if ($DumpJson ) {
            #Display JSON, and exit
            Write-Host $NewVMJson
            return
        }

        # Posting the VPG JSON Request to the API
        $FullURL = $baseURL + "vpgsettings/$VPGSettingsID/vms"
        Write-Verbose $FullURL

        $PostResponse = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Post -Body $NewVMJson
    }
  <#
    
    $VPGSetting = Get-ZertoVPGSetting -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgSettingsIdentifier $VPGSettingsID
    if ( $VPGSetting -eq $null ) {
        throw "Error retrieving VPGSettings for VPGSettingsID" 
    }
    #$VPGSetting | ConvertTo-Json -Depth 20
 
    Write-Verbose  $VPGSetting
  #>
    if (-not $VPGCommit) {
        Write-Host "VPG Setting $VPGSettingsID created.  Commit with '" -NoNewline -ForegroundColor Red
        Write-Host "Submit-ZertoVPGSetting -ZertoVpgSettingsIdentifier $VPGSettingsID" -ForegroundColor Cyan -NoNewline
        Write-Host "'" -ForegroundColor Red
        return $VPGSettingsID
    }
    #Returns VPG Task ID
    $Result = Submit-ZertoVPGSetting -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgSettingsIdentifier $VPGSettingsID
    return $Result
}
# .