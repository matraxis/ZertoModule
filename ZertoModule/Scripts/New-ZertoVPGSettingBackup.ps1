Function New-ZertoVPGSettingBackup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Zerto Backup Repository ID')] [string] $RepositoryIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Retention Period')] [ZertoVPGSettingsBackupRetentionPeriod] $RetentionPeriod, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Retry')] [ZertoVPGSettingBackupRetry] $Retry, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Scheduler')] [ZertoVPGSettingBackupScheduler] $Scheduler, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Backup')] [PSCustomObject] $VPGSettingBackup
    )
    
    if (-not $VPGSettingBackup) {
        [ZertoVPGSettingBackup] $NewObj = [ZertoVPGSettingBackup]::New($RepositoryIdentifier, $RetentionPeriod, $Retry, $Scheduler);
    }
    else {
        [ZertoVPGSettingBackup] $NewObj = [ZertoVPGSettingBackup]::New($VPGSettingBackup)
    }

    Return $NewObj
}