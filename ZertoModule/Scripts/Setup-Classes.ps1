enum ZertoVPGStatus {
    Initializing = 0
    MeetingSLA = 1
    NotMeetingSLA = 2
    HistoryNotMeetingSLA = 3
    RpoNotMeetingSLA = 4
    FailingOver = 5
    Moving = 6
    Deleting = 7
    Recovered = 8 
}

enum ZertoVPGSubstatus {
    None = 0
    InitialSync = 1
    Creating = 2
    VolumeInitialSync = 3
    Sync = 4
    RecoveryPossible = 5
    DeltaSync = 6
    NeedsConfiguration = 7
    Error = 8
    EmptyProtectionGroup = 9
    DisconnectedFromPeerNoRecoveryPoints = 10
    FullSync = 11
    VolumeDeltaSync = 12
    VolumeFullSync = 13
    FailingOverCommitting = 14
    FailingOverBeforeCommit = 15
    FailingOverRollingBack = 16
    Promoting = 17
    MovingCommitting = 18
    MovingBeforeCommit = 19
    MovingRollingBack = 20
    Deleting = 21
    PendingRemove = 22
    BitmapSync = 23
    DisconnectedFromPeer = 24
    ReplicationPausedUserInitiated = 25
    ReplicationPausedSystemInitiated = 26
    RecoveryStorageProfileError = 27
    Backup = 28
    RollingBack = 29
    RecoveryStorageError = 30
    JournalStorageError = 31
    VmNotProtectedError = 32 
}

enum ZertoProtectedSiteType {
    VCVpg = 0
    VCvApp = 1
    VCDvApp = 2
    AWS = 3
    HyperV = 4  
}

enum ZertoRecoverySiteType {
    VCVpg = 0
    VCvApp = 1
    VCDvApp = 2
    AWS = 3
    HyperV = 4  
}

enum ZertoVPGPriority {
    Low = 0
    Medium = 1
    High = 2 
}

enum ZertoVRAStatus {
    Installed = 0
    UnsupportedEsxVersion = 1
    NotInstalled = 2
    Installing = 3
    Removing = 4
    InstallationError = 5
    HostPasswordChanged = 6
    UpdatingIpSettings = 7
    DuringChangeHost = 8  
}

enum ZertoPairingStatus {
    Paired = 0
    Pairing = 1
    Unpaired = 2 
}

enum ZertoAlertLevel {
    Warning = 0
    Error = 1 
}

enum ZertoAlertEntity {
    Zvm = 0
    Vra = 1
    Vpg = 2
    CloudConnector = 3
    Storage = 4
    License = 5
    Zcm = 6
    FileRecoveryComponent = 7  
}

enum ZertoAlertHelpIdentifier {
    AWS0001 = 0
    BCK0001 = 1
    BCK0002 = 2
    BCK0005 = 3
    BCK0006 = 4
    BCK0007 = 5
    LIC0001 = 6
    LIC0002 = 7
    LIC0003 = 8
    LIC0004 = 9
    LIC0005 = 10
    LIC0006 = 11
    LIC0007 = 12
    LIC0008 = 13
    STR0001 = 14
    STR0002 = 15
    STR0004 = 16
    VCD0001 = 17
    VCD0002 = 18
    VCD0003 = 19
    VCD0004 = 20
    VCD0005 = 21
    VCD0006 = 22
    VCD0007 = 23
    VCD0010 = 24
    VCD0014 = 25
    VCD0015 = 26
    VCD0016 = 27
    VCD0017 = 28
    VCD0018 = 29
    VCD0020 = 30
    VCD0021 = 31
    VPG0003 = 32
    VPG0004 = 33
    VPG0005 = 34
    VPG0006 = 35
    VPG0007 = 36
    VPG0008 = 37
    VPG0009 = 38
    VPG0010 = 39
    VPG0011 = 40
    VPG0012 = 41
    VPG0014 = 42
    VPG0015 = 43
    VPG0016 = 44
    VPG0017 = 45
    VPG0018 = 46
    VPG0019 = 47
    VPG0020 = 48
    VPG0021 = 49
    VPG0022 = 50
    VPG0023 = 51
    VPG0024 = 52
    VPG0025 = 53
    VPG0026 = 54
    VPG0027 = 55
    VPG0028 = 56
    VPG0035 = 57
    VPG0036 = 58
    VPG0037 = 59
    VPG0038 = 60
    VPG0039 = 61
    VPG0040 = 62
    VPG0041 = 63
    VPG0042 = 64
    VPG0043 = 65
    VPG0044 = 66
    VPG0045 = 67
    VPG0046 = 68
    VPG0047 = 69
    VPG0048 = 70
    VRA0001 = 71
    VRA0002 = 72
    VRA0003 = 73
    VRA0004 = 74
    VRA0005 = 75
    VRA0006 = 76
    VRA0007 = 77
    VRA0008 = 78
    VRA0009 = 79
    VRA0010 = 80
    VRA0011 = 81
    VRA0012 = 82
    VRA0013 = 83
    VRA0014 = 84
    VRA0015 = 85
    VRA0016 = 86
    VRA0017 = 87
    VRA0018 = 88
    VRA0019 = 89
    VRA0020 = 90
    VRA0021 = 91
    VRA0022 = 92
    VRA0023 = 93
    VRA0024 = 94
    VRA0025 = 95
    VRA0026 = 96
    VRA0027 = 97
    VRA0028 = 98
    VRA0029 = 99
    VRA0030 = 100
    VRA0032 = 101
    VRA0035 = 102
    VRA0036 = 103
    VRA0037 = 104
    VRA0038 = 105
    VRA0039 = 106
    VRA0040 = 107
    VRA0049 = 108
    VRA0050 = 109
    VRA0051 = 110
    VRA0052 = 111
    VRA0053 = 112
    VRA0054 = 113
    VRA0055 = 114
    ZCC0001 = 115
    ZCC0002 = 116
    ZCC0003 = 117
    ZCM0001 = 118
    ZVM0001 = 119
    ZVM0002 = 120
    ZVM0003 = 121
    ZVM0004 = 122
    ZVM0005 = 123
    ZVM0006 = 124
    ZVM0007 = 125
    ZVM0008 = 126
    ZVM0009 = 127
    ZVM0010 = 128
    ZVM0011 = 129
    ZVM0012 = 130
    ZVM0013 = 131
    ZVM0014 = 132
    ZVM0015 = 133
    FLR0001 = 134
    Unknown = 135 
}

enum ZertoEventType {
    Unknown = 0
    CreateProtectionGroup = 1
    RemoveProtectionGroup = 2
    FailOver = 3
    FailOverTest = 4
    StopFailOverTest = 5
    Move = 6
    ProtectVM = 7
    UnprotectVM = 8
    InstallVra = 9
    UninstallVra = 10
    UpdateProtectionGroup = 11
    InsertTaggedCP = 12
    HandleMirrorPromotion = 13
    ActivateAllMirrors = 14
    LogCollection = 15
    ForceReconfigurationOfNewVM = 16
    ClearSite = 17
    ForceRemoveProtectionGroup = 18
    ForceUpdateProtectionGroup = 19
    ForceKillProtectionGroup = 20
    PrePostScript = 21
    InitFullSync = 22
    Pair = 23
    Unpair = 24
    InstallCloudConnector = 25
    UninstallCloudConnector = 26
    RedeployCloudConnector = 27
    ScriptExecutionFailure = 28
    SetAdvancedSiteSettings = 29
    Clone = 30
    KeepDisk = 31
    FailoverBeforeCommit = 32
    FailoverCommit = 33
    FailoverRollback = 34
    MoveBeforeCommit = 35
    MoveRollback = 36
    MoveCommit = 37
    MaintainHost = 38
    UpgradeVra = 39
    MoveProtectionGroupToManualOperationNeeded = 40
    ChangeVraIpSettings = 41
    PauseProtectionGroup = 42
    ResumeProtectionGroup = 43
    UpgradeZVM = 44
    BulkUpgradeVras = 45
    BulkUninstallVras = 46
    AlertTurnedOn = 47
    AlertTurnedOff = 48
    ChangeVraPassword = 49
    ChangeRecoveryHost = 50
    BackupProtectionGroup = 51
    CleanupProtectionGroupVipDiskbox = 52
    RestoreProtectionGroup = 53
    PreScript = 54
    PostScript = 55
    RemoveVmFromVc = 56
    ChangeVraPasswordIpSettings = 57
    FlrJournalMount = 58
    FlrJournalUnmount = 59
    Login = 60 
}

enum ZertoEventCategory {
    All = 0
    Events = 1
    Alerts = 2 
}

enum ZertoCommitPolicy {
    Rollback = 0
    Commit = 1
    None = 2 
}

enum ZertoShutdownPolicy {
    None = 0
    Shutdown = 1
    ForceShutdown = 2 
}

enum ZertoVRAIPConfigType {
    Dhcp = 0
    Static = 1 
}

enum ZertoTaskTypes {
    CreateProtectionGroup = 0
    RemoveProtectionGroup = 1
    FailOver = 2
    FailOverTest = 3
    StopFailOverTest = 4
    Move = 5
    GetCheckpointList = 6
    ProtectVM = 7
    UnprotectVM = 8
    AddVMToProtectionGroup = 9
    RemoveVMFromProtectionGroup = 10
    InstallVra = 11
    UninstallVra = 12
    GetVMSettings = 13
    UpdateProtectionGroup = 14
    InsertTaggedCP = 15
    WaitForCP = 16
    HandleMirrorPromotion = 17
    ActivateAllMirrors = 18
    LogCollection = 19
    ClearCheckpoints = 20
    ForceReconfigurationOfNewVM = 21
    ClearSite = 22
    ForceRemoveProtectionGroup = 23
    ForceUpdateProtectionGroup = 24
    ForceKillProtectionGroup = 25
    PrePostScript = 26
    InitFullSync = 27
    Pair = 28
    Unpair = 29
    AddPeerVraInfo = 30
    RemovePeerVraInfo = 31
    InstallCloudConnector = 32
    UninstallCloudConnector = 33
    HandleFirstSyncDone = 34
    Clone = 35
    MoveBeforeCommit = 36
    MoveRollback = 37
    MoveCommit = 38
    UpgradeVRA = 39
    MaintainHost = 40
    NotSupportedInThisVersion = 41
    MoveProtectionGroupToManualOperationNeeded = 42
    FailoverBeforeCommit = 43
    FailoverCommit = 44   
}

enum ZertoTaskStates {
    FirstUnusedValue = 0
    InProgress = 1
    WaitingForUserInput = 2
    Paused = 3
    Failed = 4
    Stopped = 5
    Completed = 6
    Cancelling = 7 
}

enum ZertoVPGSettingsBackupRetentionPeriod  {
    OneWeek = 0
    OneMonth = 1
    ThreeMonths = 2
    SixMonths = 3
    NineMonths = 4
    OneYear = 5 
}

enum ZertoVPGSettingsBackupSchedulerDOW {
    Sunday = 0
    Monday = 1
    Tuesday = 2
    Wednesday = 3
    Thursday = 4
    Friday = 5
    Saturday = 6 
}

enum ZertoVPGSettingsBackupSchedulerPeriod  {
    Daily = 0
    Weekly = 1 
}

class VPGFailoverIPAddress {
    [string] $NICName
    [String] $NetworkID
    [bool]   $ReplaceMAC
    [bool]   $UseDHCP
    [String] $IPAddress
    [String] $SubnetMask
    [String] $Gateway
    [String] $DNS1
    [String] $DNS2
    [String] $DNSSuffix
    [String] $TestNetworkID
    [bool]   $TestReplaceMAC
    [bool]   $TestUseDHCP
    [String] $TestIPAddress
    [String] $TestSubnetMask
    [String] $TestGateway
    [String] $TestDNS1
    [String] $TestDNS2
    [String] $TestDNSSuffix


    #CTOR for default + DHCP
    VPGFailoverIPAddress ([string] $NICName, [String] $NetworkID, [bool] $ReplaceMAC, [bool] $UseDHCP, [String] $DNSSuffix, [String] $TestNetworkID, [bool] $TestReplaceMAC, [bool] $TestUseDHCP, [String] $TestDNSSuffix) {
        $this.NICName = $NICName
        $this.NetworkID = $NetworkID
        $this.ReplaceMAC = $ReplaceMAC
        $this.TestNetworkID = $TestNetworkID
        $this.TestReplaceMAC = $TestReplaceMAC
        $this.UseDHCP = $UseDHCP
        $this.DNSSuffix = $DNSSuffix
        $this.TestUseDHCP = $TestUseDHCP
        $this.TestDNSSuffix = $TestDNSSuffix
    }

    #CTOR for default + IP
    VPGFailoverIPAddress ([string] $NICName, [String] $NetworkID, [bool] $ReplaceMAC, [String] $IPAddress, [String] $Subnetmask, [String] $Gateway, [String] $DNS1, [String] $DNS2, [String] $DNSSuffix, [String] $TestNetworkID, [bool] $TestReplaceMAC, [String] $TestIPAddress, [String] $TestSubnetMask, [String] $TestGateway, [String] $TestDNS1, [String] $TestDNS2, [String] $TestDNSSuffix ) {
        $this.NICName = $NICName
        $this.NetworkID = $NetworkID
        $this.ReplaceMAC = $ReplaceMAC
        $this.TestNetworkID = $TestNetworkID
        $this.TestReplaceMAC = $TestReplaceMAC
        $this.UseDHCP = $false
        $this.IPAddress = $IPAddress
        $this.Subnetmask = $Subnetmask
        $this.Gateway = $Gateway
        $this.DNS1 = $DNS1
        $this.DNS2 = $DNS2
        $this.DNSSuffix = $DNSSuffix
        $this.TestUseDHCP = $false
        $this.TestIPAddress = $TestIPAddress
        $this.TestSubnetMask = $TestSubnetMask
        $this.TestGateway = $TestGateway
        $this.TestDNS1 = $TestDNS1
        $this.TestDNS2 = $TestDNS2
        $this.TestDNSSuffix = $TestDNSSuffix        
    }
    
}

class VPGVMRecovery {
    [string] $DatastoreClusterIdentifier
    [string] $DatastoreIdentifier
    [string] $FolderIdentifier
    [string] $HostClusterIdentifier
    [string] $HostIdentifier
    [string] $ResourcePoolIdentifier

    VPGVMRecovery ([PSCustomObject] $Value) {
        $this.DatastoreClusterIdentifier = $Value.DatastoreClusterIdentifier
        $this.DatastoreIdentifier = $Value.DatastoreIdentifier     
        $this.FolderIdentifier = $Value.FolderIdentifier
        $this.HostClusterIdentifier = $Value.HostClusterIdentifier
        $this.HostIdentifier = $Value.HostIdentifier
        $this.ResourcePoolIdentifier = $Value.ResourcePoolIdentifier
    }    
    
    VPGVMRecovery ([string] $DatastoreClusterIdentifier, [string] $DatastoreIdentifier, [string] $FolderIdentifier, [string] $HostClusterIdentifier, [string] $HostIdentifier, [string] $ResourcePoolIdentifier) {
        $this.DatastoreClusterIdentifier = $DatastoreClusterIdentifier
        $this.DatastoreIdentifier = $DatastoreIdentifier     
        $this.FolderIdentifier = $FolderIdentifier
        $this.HostClusterIdentifier = $HostClusterIdentifier
        $this.HostIdentifier = $HostIdentifier
        $this.ResourcePoolIdentifier = $ResourcePoolIdentifier
    }        
}

# .ExternalHelp ZertoModule.psm1-help.xml


class VPGVirtualMachine {
    [string] $VMName
    [VPGFailoverIPAddress[]] $VPGFailoverIPAddresses
    [VPGVMRecovery] $VPGVMRecovery
    #Add other parts of the VPG here

    #region base CTOR
    VPGVirtualMachine ([string] $VMName) {
        $this.VMName = $VMName
        $this.VPGFailoverIPAddresses = @()
        #Initialize othe parts of the VPG here
    }
    #endregion

    #region CTOR with Addresses
    #VPGVirtualMachine ([string] $VMName, [FailoverIPAddress[]] $FailoverIPAddress ) {
    #    $this.VMName = $VMName
    #    $this.FailoverIPAddresses = @()
    #    $FailoverIPAddress | ForEach-Object {
    #        $this.FailoverIPAddresses += $_
    #    }
    #}
    #endregion

    AddVPGFailoverIPAddress ([VPGFailoverIPAddress[]] $VPGFailoverIPAddresses) {
        $VPGFailoverIPAddresses | ForEach-Object {
            $this.VPGFailoverIPAddresses += $_
        }
    }
    AddVPGVMRecovery ([VPGVMRecovery] $VPGVMRecovery) {
        $this.VPGVMRecovery = $VPGVMRecovery
    }

    #Add methods to add/update other parts of the VPG here
}

# .ExternalHelp ZertoModule.psm1-help.xml


class VRAIPAddressConfig {
    [String] $IPAddress
    [String] $SubnetMask
    [String] $Gateway
    [string] $VRAIPType

    #region base CTOR
    VRAIPAddressConfig ([String] $IPAddress, [String] $SubnetMask, [String] $Gateway, [ZertoVRAIPConfigType] $VRAIPType) {
        $this.IPAddress = $IPAddress
        $this.SubnetMask = $SubnetMask
        $this.Gateway = $Gateway
        $this.VRAIPType = $VRAIPType.ToString()
    }
    #endregion
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingBackupRetry {
    [int] $IntervalInMinutes 
    [int] $Number 
    [bool] $Retry

    ZertoVPGSettingBackupRetry ([PSCustomObject] $Value) {
        $this.IntervalInMinutes = $Value.IntervalInMinutes 
        $this.Number = $Value.Number
        $this.Retry = $Value.Retry
    }    
    ZertoVPGSettingBackupRetry ([int] $IntervalInMinutes, [int] $Number, [bool] $Retry) {
        $this.IntervalInMinutes = $IntervalInMinutes 
        $this.Number = $Number
        $this.Retry = $Retry
    }   
}

# .ExternalHelp ZertoModule.psm1-help.xml

    
class ZertoVPGSettingBackupScheduler {
    [string] $DayOfWeek 
    [string] $SchedulerPeriod 
    [string] $TimeOfDay

    ZertoVPGSettingBackupScheduler ([PSCustomObject] $Value) {
        $this.DayOfWeek = $Value.DayOfWeek 
        $this.SchedulerPeriod = $Value.SchedulerPeriod
        $this.TimeOfDay = $Value.TimeOfDay
    }    
    ZertoVPGSettingBackupScheduler ([ZertoVPGSettingsBackupSchedulerDOW] $DayOfWeek, [ZertoVPGSettingsBackupSchedulerPeriod] $SchedulerPeriod, [string] $TimeOfDay) {
        $this.DayOfWeek = $DayOfWeek.ToString() 
        $this.SchedulerPeriod = $SchedulerPeriod.ToString()
        $this.TimeOfDay = $TimeOfDay
    }   
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingBackup {
    [string] $RepositoryIdentifier 
    [string] $RetentionPeriod 
    [ZertoVPGSettingBackupRetry] $Retry
    [ZertoVPGSettingBackupScheduler] $Scheduler

    ZertoVPGSettingBackup ([PSCustomObject] $Value) {
        $this.RepositoryIdentifier = $Value.RepositoryIdentifier 
        $this.RetentionPeriod = $Value.RetentionPeriod 
        $this.Retry = $Value.Retry 
        $this.Scheduler = $Value.Scheduler 
    }    
    ZertoVPGSettingBackup ([string] $RepositoryIdentifier, [ZertoVPGSettingsBackupRetentionPeriod] $RetentionPeriod, [ZertoVPGSettingBackupRetry] $Retry, [ZertoVPGSettingBackupScheduler] $Scheduler ) {
        $this.RepositoryIdentifier = $RepositoryIdentifier 
        $this.RetentionPeriod = $RetentionPeriod.ToString() 
        $this.Retry = $Retry 
        $this.Scheduler = $Scheduler 
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


Class ZertoVPGSettingBasic {
    [int] $JournalHistoryInHours 
    [string] $Name 
    [ZertoVPGPriority] $Priority 
    [string] $ProtectedSiteIdentifier 
    [string] $RecoverySiteIdentifier 
    [int] $RpoInSeconds 
    [string] $ServiceProfileIdentifier
    [int] $TestIntervalInMinutes 
    [Boolean] $UseWanCompression 
    [string] $ZorgIdentifier 

    ZertoVPGSettingBasic ([PSCustomObject] $Value) {
        $this.JournalHistoryInHours = $Value.JournalHistoryInHours                                                
        $this.Name = $Value.Name                   
        $this.Priority = $Value.Priority 
        $this.ProtectedSiteIdentifier = $Value.ProtectedSiteIdentifier 
        $this.RecoverySiteIdentifier = $Value.RecoverySiteIdentifier 
        $this.RpoInSeconds = $Value.RpoInSeconds                 
        $this.ServiceProfileIdentifier = $Value.ServiceProfileIdentifier | StringOrNull
        $this.TestIntervalInMinutes = $Value.TestIntervalInMinutes        
        $this.UseWanCompression = $Value.UseWanCompression    
        $this.ZorgIdentifier = $Value.ZorgIdentifier | StringOrNull 
    }    
    ZertoVPGSettingBasic ([int] $JournalHistoryInHours, [string] $Name, [ZertoVPGPriority] $Priority, [string] $ProtectedSiteIdentifier, [string] $RecoverySiteIdentifier, [int] $RpoInSeconds, [string] $ServiceProfileIdentifier, [int] $TestIntervalInMinutes, [Boolean] $UseWanCompression, [string] $ZorgIdentifier) {
        $this.JournalHistoryInHours = $JournalHistoryInHours 
        $this.Name = $Name
        $this.Priority = $Priority
        $this.ProtectedSiteIdentifier = $ProtectedSiteIdentifier
        $this.RecoverySiteIdentifier = $RecoverySiteIdentifier
        $this.RpoInSeconds = $RpoInSeconds
        $this.ServiceProfileIdentifier = $ServiceProfileIdentifier | StringOrNull 
        $this.TestIntervalInMinutes = $TestIntervalInMinutes
        $this.UseWanCompression = $UseWanCompression
        $this.ZorgIdentifier = $ZorgIdentifier | StringOrNull 
    }                 
}

# .ExternalHelp ZertoModule.psm1-help.xml


Class ZertoVPGSettingBootGroupsBootGroups {
    [int] $BootDelayInSeconds 
    [string] $BootGroupIdentifier 
    [string] $Name

    ZertoVPGSettingBootGroupsBootGroups ([PSCustomObject] $Value) {
        $this.BootDelayInSeconds = $Value.BootDelayInSeconds
        $this.BootGroupIdentifier = $Value.BootGroupIdentifier | StringOrNull 
        $this.Name = $Value.Name
    }    
    ZertoVPGSettingBootGroupsBootGroups ([int] $BootDelayInSeconds, [string] $BootGroupIdentifier, [string] $Name ) {
        $this.BootDelayInSeconds = $BootDelayInSeconds
        $this.BootGroupIdentifier = $BootGroupIdentifier | StringOrNull  
        $this.Name = $Name
    }                 
}

# .ExternalHelp ZertoModule.psm1-help.xml


Class ZertoVPGSettingBootGroups {
    [ZertoVPGSettingBootGroupsBootGroups[]] $BootGroups 

    ZertoVPGSettingBootGroups ([PSCustomObject] $Value) {
        $this.BootGroups = $Value.BootGroups
    }    
    ZertoVPGSettingBootGroups ([ZertoVPGSettingBootGroupsBootGroups[]] $BootGroups ) {
        $this.BootGroups = $BootGroups
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


Class ZertoVPGSettingJournalLimitation {
    [int] $HardLimitInMB 
    [int] $HardLimitInPercent 
    [int] $WarningThresholdInMB
    [int] $WarningThresholdInPercent

    ZertoVPGSettingJournalLimitation ([PSCustomObject] $Value) {
        $this.HardLimitInMB = $Value.HardLimitInMB                                                
        $this.HardLimitInPercent = $Value.HardLimitInPercent                                                
        $this.WarningThresholdInMB = $Value.WarningThresholdInMB                                                
        $this.WarningThresholdInPercent = $Value.WarningThresholdInPercent                                                
    }    
    ZertoVPGSettingJournalLimitation ([int] $HardLimitInMB, [int] $HardLimitInPercent, [int] $WarningThresholdInMB, [int] $WarningThresholdInPercent ) {
        $this.HardLimitInMB = $HardLimitInMB                                                
        $this.HardLimitInPercent = $HardLimitInPercent                                                
        $this.WarningThresholdInMB = $WarningThresholdInMB                                                
        $this.WarningThresholdInPercent = $WarningThresholdInPercent                    
    }                 
}

# .ExternalHelp ZertoModule.psm1-help.xml


Class ZertoVPGSettingJournal {
    [string] $DatastoreClusterIdentifier 
    [string] $DatastoreIdentifier 
    [ZertoVPGSettingJournalLimitation] $Limitation

    ZertoVPGSettingJournal ([PSCustomObject] $Value) {
        $this.DatastoreClusterIdentifier = $Value.DatastoreClusterIdentifier | StringOrNull                                                 
        $this.DatastoreIdentifier = $Value.DatastoreIdentifier | StringOrNull 
        $this.Limitation = $Value.Limitation                   
    }    
    ZertoVPGSettingJournal ([string] $DatastoreClusterIdentifier, [string] $DatastoreIdentifier, [ZertoVPGSettingJournalLimitation] $Limitation) {
        $this.DatastoreClusterIdentifier = $DatastoreClusterIdentifier | StringOrNull                                                 
        $this.DatastoreIdentifier = $DatastoreIdentifier | StringOrNull 
        $this.Limitation = $Limitation                   
    }                 
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingNetworksNetworkHypervisor {
    [String] $DefaultNetworkIdentifier

    ZertoVPGSettingNetworksNetworkHypervisor ([PSCustomObject] $Value) {
        $this.DefaultNetworkIdentifier = $Value.DefaultNetworkIdentifier | StringOrNull  
    }    
    ZertoVPGSettingNetworksNetworkHypervisor ([string] $DefaultNetworkIdentifier) {
        $this.DefaultNetworkIdentifier = $DefaultNetworkIdentifier | StringOrNull  
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingNetworksNetwork {
    [ZertoVPGSettingNetworksNetworkHypervisor] $Hypervisor

    ZertoVPGSettingNetworksNetwork ([PSCustomObject] $Value) {
        $this.Hypervisor = $Value.Hypervisor 
    }    
    ZertoVPGSettingNetworksNetwork ([ZertoVPGSettingNetworksNetworkHypervisor] $Hypervisor) {
        $this.Hypervisor = $Hypervisor 
    }  
}

# .ExternalHelp ZertoModule.psm1-help.xml

class ZertoVPGSettingNetworks {
    [ZertoVPGSettingNetworksNetwork] $Failover
    [ZertoVPGSettingNetworksNetwork] $FailoverTest

    ZertoVPGSettingNetworks ([PSCustomObject] $Value) {
        $this.Failover = $Value.Failover 
        $this.FailoverTest = $Value.FailoverTest 
    }    
    ZertoVPGSettingNetworks ([ZertoVPGSettingNetworksNetwork] $Failover, [ZertoVPGSettingNetworksNetwork] $FailoverTest) {
        $this.Failover = $Failover 
        $this.FailoverTest = $FailoverTest 
    }  
}

# .ExternalHelp ZertoModule.psm1-help.xml


Class ZertoVPGSettingRecovery {
    [string] $DefaultDatastoreIdentifier 
    [string] $DefaultFolderIdentifier 
    [string] $DefaultHostClusterIdentifier 
    [string] $DefaultHostIdentifier 
    [string] $ResourcePoolIdentifier 

    ZertoVPGSettingRecovery ([PSCustomObject] $Value) {
        $this.DefaultDatastoreIdentifier = $Value.DefaultDatastoreIdentifier | StringOrNull
        $this.DefaultFolderIdentifier = $Value.DefaultFolderIdentifier | StringOrNull 
        $this.DefaultHostClusterIdentifier = $Value.DefaultHostClusterIdentifier | StringOrNull  
        $this.DefaultHostIdentifier = $Value.DefaultHostIdentifier | StringOrNull 
        $this.ResourcePoolIdentifier = $Value.ResourcePoolIdentifier | StringOrNull 
    }    
    ZertoVPGSettingRecovery ([string] $DefaultDatastoreIdentifier, [string] $DefaultFolderIdentifier, [string] $DefaultHostClusterIdentifier, [string] $DefaultHostIdentifier, [string] $ResourcePoolIdentifier ) {
        #Handle the nulls.  PS converts a $null in a [string] as a string.empty. 
        $this.DefaultDatastoreIdentifier = $DefaultDatastoreIdentifier | StringOrNull 
        $this.DefaultFolderIdentifier = $DefaultFolderIdentifier | StringOrNull 
        $this.DefaultHostClusterIdentifier = $DefaultHostClusterIdentifier | StringOrNull 
        $this.DefaultHostIdentifier = $DefaultHostIdentifier | StringOrNull 
        $this.ResourcePoolIdentifier = $ResourcePoolIdentifier | StringOrNull 
    }                 
}

# .ExternalHelp ZertoModule.psm1-help.xml

class ZertoVPGSettingScript {
    [String] $Command
    [string] $Parameters
    [int] $TimeoutInSeconds

    ZertoVPGSettingScript ([PSCustomObject] $Value) {
        $this.Command = $Value.Command | StringOrNull 
        $this.Parameters = $Value.Parameters | StringOrNull
        $this.TimeoutInSeconds = $Value.TimeoutInSeconds  
    }    
    ZertoVPGSettingScript ([string] $Command, [string] $Parameters, [int] $TimeoutInSeconds ) {
        $this.Command = $Command | StringOrNull 
        $this.Parameters = $Parameters | StringOrNull 
        $this.TimeoutInSeconds = $TimeoutInSeconds 
    }  

}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingScripting {
    [ZertoVPGSettingScript] $PostBackup
    [ZertoVPGSettingScript] $PostRecovery
    [ZertoVPGSettingScript] $PreRecovery

    ZertoVPGSettingScripting ([PSCustomObject] $Value) {
        $this.PostBackup = $Value.PostBackup 
        $this.PostRecovery = $Value.PostRecovery 
        $this.PreRecovery = $Value.PreRecovery 
    }    
    ZertoVPGSettingScripting ([ZertoVPGSettingScript] $PostBackup, [ZertoVPGSettingScript] $PostRecovery, [ZertoVPGSettingScript] $PreRecovery ) {
        $this.PostBackup = $PostBackup 
        $this.PostRecovery = $PostRecovery 
        $this.PreRecovery = $PreRecovery 
    }  
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVMNicNetworkHypervisorIpConfig {
    [string] $Gateway
    [bool] $IsDhcp 
    [string] $PrimaryDns 
    [string] $SecondaryDns
    [string] $StaticIp 
    [string] $SubnetMask 

    ZertoVPGSettingVMNicNetworkHypervisorIpConfig ([PSCustomObject] $Value) {
        $this.Gateway = $value.Gateway
        $this.IsDhcp = $value.IsDhcp
        $this.PrimaryDns = $value.PrimaryDns
        $this.SecondaryDns = $value.SecondaryDns
        $this.StaticIp = $value.StaticIp
        $this.SubnetMask = $value.SubnetMask
    }
    ZertoVPGSettingVMNicNetworkHypervisorIpConfig ([string] $Gateway,
        [bool] $IsDhcp, 
        [string] $PrimaryDns,
        [string] $SecondaryDns,
        [string] $StaticIp,
        [string] $SubnetMask ) {
        $this.Gateway = $Gateway
        $this.IsDhcp = $IsDhcp
        $this.PrimaryDns = $PrimaryDns
        $this.SecondaryDns = $SecondaryDns
        $this.StaticIp = $StaticIp
        $this.SubnetMask = $SubnetMask
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVMNicNetworkHypervisor {
    [string] $DnsSuffix
    [ZertoVPGSettingVMNicNetworkHypervisorIpConfig] $IpConfig
    [string] $NetworkIdentifier
    [bool] $ShouldReplaceMacAddress

    ZertoVPGSettingVMNicNetworkHypervisor ([PSCustomObject] $Value) {
        $this.DnsSuffix = $Value.DnsSuffix | StringOrNull 
        $this.IpConfig = $Value.IpConfig 
        $this.NetworkIdentifier = $Value.NetworkIdentifier | StringOrNull  
        $this.ShouldReplaceMacAddress = $Value.ShouldReplaceMacAddress 
    }
    ZertoVPGSettingVMNicNetworkHypervisor ([string] $DnsSuffix, 
        [ZertoVPGSettingVMNicNetworkHypervisorIpConfig] $IpConfig, 
        [string] $NetworkIdentifier, 
        [bool] $ShouldReplaceMacAddress) {
        $this.DnsSuffix = $DnsSuffix | StringOrNull 
        $this.IpConfig = $IpConfig 
        $this.NetworkIdentifier = $NetworkIdentifier | StringOrNull  
        $this.ShouldReplaceMacAddress = $ShouldReplaceMacAddress 
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml
  

class ZertoVPGSettingVMNicNetwork {
    [ZertoVPGSettingVMNicNetworkHypervisor] $Hypervisor

    ZertoVPGSettingVMNicNetwork ([PSCustomObject] $Value) {
        $this.Hypervisor = $Value.Hypervisor 
    }
    ZertoVPGSettingVMNicNetwork ([ZertoVPGSettingVMNicNetworkHypervisor] $Hypervisor) {
        $this.Hypervisor = $Hypervisor 
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml
   

class ZertoVPGSettingVMNic {
    [ZertoVPGSettingVMNicNetwork] $Failover
    [ZertoVPGSettingVMNicNetwork] $FailoverTest
    [string] $NicIdentifier


    ZertoVPGSettingVMNic ([PSCustomObject] $Value) {
        $this.NicIdentifier = $Value.NicIdentifier 
        $this.Failover = $Value.Failover 
        $this.FailoverTest = $Value.FailoverTest 
    }
    ZertoVPGSettingVMNic ([string] $NicIdentifier, [ZertoVPGSettingVMNicNetwork] $Failover, [ZertoVPGSettingVMNicNetwork] $FailoverTest) {
        $this.NicIdentifier = $NicIdentifier 
        $this.Failover = $Failover 
        $this.FailoverTest = $FailoverTest 
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVMRecovery {
    [string] $DatastoreClusterIdentifier
    [string] $DatastoreIdentifier
    [string] $FolderIdentifier
    [string] $HostClusterIdentifier
    [string] $HostIdentifier
    [string] $ResourcePoolIdentifier

    ZertoVPGSettingVMRecovery ([PSCustomObject] $Value) {
        $this.DatastoreClusterIdentifier = $value.DatastoreClusterIdentifier | StringOrNull 
        $this.DatastoreIdentifier = $value.DatastoreIdentifier | StringOrNull 
        $this.FolderIdentifier = $value.FolderIdentifier | StringOrNull 
        $this.HostClusterIdentifier = $value.HostClusterIdentifier | StringOrNull 
        $this.HostIdentifier = $value.HostIdentifier | StringOrNull 
        $this.ResourcePoolIdentifier = $value.ResourcePoolIdentifier | StringOrNull             
    }
    ZertoVPGSettingVMRecovery ([string] $DatastoreClusterIdentifier,
        [string] $DatastoreIdentifier,
        [string] $FolderIdentifier,
        [string] $HostClusterIdentifier,
        [string] $HostIdentifier,
        [string] $ResourcePoolIdentifier) {
        $this.DatastoreClusterIdentifier = $DatastoreClusterIdentifier | StringOrNull 
        $this.DatastoreIdentifier = $DatastoreIdentifier | StringOrNull 
        $this.FolderIdentifier = $FolderIdentifier | StringOrNull 
        $this.HostClusterIdentifier = $HostClusterIdentifier | StringOrNull 
        $this.HostIdentifier = $HostIdentifier | StringOrNull 
        $this.ResourcePoolIdentifier = $ResourcePoolIdentifier | StringOrNull    
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVMVolumeDatastore {
    [string] $DatastoreClusterIdentifier
    [string] $DatastoreIdentifier
    [bool] $IsThin

    ZertoVPGSettingVMVolumeDatastore ([PSCustomObject] $Value) {
        $this.IsThin = $value.IsThin    
        $this.DatastoreClusterIdentifier = $value.DatastoreClusterIdentifier | StringOrNull 
        $this.DatastoreIdentifier = $value.DatastoreIdentifier | StringOrNull 
    }
    ZertoVPGSettingVMVolumeDatastore ([bool] $IsThin,
        [string] $DatastoreClusterIdentifier,
        [string] $DatastoreIdentifier) {
        $this.IsThin = $IsThin    
        $this.DatastoreClusterIdentifier = $DatastoreClusterIdentifier | StringOrNull 
        $this.DatastoreIdentifier = $DatastoreIdentifier | StringOrNull 
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVMVolumeExistingVolume {
    [string] $DatastoreIdentifier
    [string] $ExistingVmIdentifier
    [string] $Mode
    [string] $Path

    ZertoVPGSettingVMVolumeExistingVolume ([PSCustomObject] $Value) {
        $this.DatastoreIdentifier = $value.DatastoreIdentifier | StringOrNull 
        $this.ExistingVmIdentifier = $value.ExistingVmIdentifier
        $this.Mode = $value.Mode
        $this.Path = $value.Path
    }
    ZertoVPGSettingVMVolumeExistingVolume ([string] $DatastoreIdentifier,
        [string] $ExistingVmIdentifier,
        [string] $Mode,
        [string] $Path) {
        $this.DatastoreIdentifier = $DatastoreIdentifier | StringOrNull 
        $this.ExistingVmIdentifier = $ExistingVmIdentifier
        $this.Mode = $Mode
        $this.Path = $Path
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVMVolume {
    [ZertoVPGSettingVMVolumeDatastore] $Datastore
    [ZertoVPGSettingVMVolumeExistingVolume] $ExistingVolume
    [bool] $IsSwap
    [string] $VolumeIdentifier

    ZertoVPGSettingVMVolume ([PSCustomObject] $Value) {
        $this.IsSwap = $value.IsSwap    
        $this.VolumeIdentifier = $value.VolumeIdentifier
        $this.Datastore = $value.Datastore
        $this.ExistingVolume = $value.ExistingVolume
    }
    ZertoVPGSettingVMVolume ([bool] $IsSwap,
        [string] $VolumeIdentifier,
        [ZertoVPGSettingVMVolumeDatastore] $Datastore,
        [ZertoVPGSettingVMVolumeExistingVolume] $ExistingVolume) {
        $this.IsSwap = $IsSwap    
        $this.VolumeIdentifier = $VolumeIdentifier
        $this.Datastore = $Datastore
        $this.ExistingVolume = $ExistingVolume 
    }
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSettingVM {
    [string] $BootGroupIdentifier
    [ZertoVPGSettingJournal] $Journal
    [ZertoVPGSettingVMNic[]] $NICs
    [ZertoVPGSettingVMRecovery] $Recovery
    [string] $VmIdentifier
    [ZertoVPGSettingVMVolume[]] $Volumes 

    ZertoVPGSettingVM ([PSCustomObject] $Value) {
        $this.BootGroupIdentifier = $Value.BootGroupIdentifier 
        $this.Journal = $Value.Journal 

        $this.NICs = @()
        $Value.NICs | ForEach-Object { $this.NICs += $_ }
        $this.Recovery = $Value.Recovery 
        $this.VmIdentifier = $Value.VmIdentifier 
        $this.Volumes = @()
        $Value.Volumes | ForEach-Object { $this.Volumes += $_ }
    }    
    ZertoVPGSettingVM ([string] $BootGroupIdentifier, [ZertoVPGSettingJournal] $Journal, [ZertoVPGSettingVMNic[]] $VMNICs, [ZertoVPGSettingVMRecovery] $VMRecovery, [string] $VmIdentifier, [ZertoVPGSettingVMVolume[]] $VMVolumes ) {
        $this.BootGroupIdentifier = $BootGroupIdentifier 
        $this.Journal = $Journal 
        $this.VMNICs = $VMNICs 
        $this.VMRecovery = $VMRecovery 
        $this.VmIdentifier = $VmIdentifier 
        $this.VMVolumes = $VMVolumes 
    }  
}

# .ExternalHelp ZertoModule.psm1-help.xml


class ZertoVPGSetting {
    [ZertoVPGSettingBackup] $Backup
    [ZertoVPGSettingBasic] $Basic
    [ZertoVPGSettingBootGroups] $BootGroups
    [ZertoVPGSettingJournal] $Journal
    [ZertoVPGSettingNetworks] $Networks
    [ZertoVPGSettingRecovery] $Recovery
    [ZertoVPGSettingScripting] $Scripting
    [ZertoVPGSettingVM[]] $Vms
    [string] $VpgIdentifier
    [string] $VpgSettingsIdentifier

    ZertoVPGSetting ([PSCustomObject] $Value) {
        $this.Backup = $Value.Backup
        $this.Basic = $Value.Basic
        $this.BootGroups = $Value.BootGroups            
        $this.Journal = $Value.Journal
        $this.Networks = $Value.Networks
        $this.Recovery = $Value.Recovery
        $this.Scripting = $Value.Scripting
        $this.Vms = @()
        $Value.Vms | ForEach-Object { $this.Vms += $_ }
        $this.VpgIdentifier = $Value.VpgIdentifier
        $this.VpgSettingsIdentifier = $Value.VpgSettingsIdentifier
    }    
    ZertoVPGSetting ([ZertoVPGSettingBackup] $Backup, [ZertoVPGSettingBasic] $Basic, [ZertoVPGSettingBootGroups] $BootGroups, [ZertoVPGSettingJournal] $Journal, [ZertoVPGSettingNetworks] $Networks, [ZertoVPGSettingRecovery] $Recovery, [ZertoVPGSettingScripting] $Scripting, [ZertoVPGSettingVM[]] $Vms, [string] $VpgIdentifier, [string] $VpgSettingsIdentifier
    ) {
        $this.Backup = $Backup
        $this.Basic = $Basic
        $this.BootGroups = $BootGroups
        $this.Journal = $Journal
        $this.Networks = $Networks
        $this.Recovery = $Recovery
        $this.Scripting = $Scripting
        $this.Vms = $Vms
        $this.VpgIdentifier = $VpgIdentifier
        $this.VpgSettingsIdentifier = $VpgSettingsIdentifier
    }  
}