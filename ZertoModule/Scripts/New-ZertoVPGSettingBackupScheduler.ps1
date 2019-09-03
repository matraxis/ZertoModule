Function New-ZertoVPGSettingBackupScheduler {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Day of week the backup will run')] [ZertoVPGSettingsBackupSchedulerDOW] $DayOfWeek, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Scheduler Period (Daily|Weekly)')] [ZertoVPGSettingsBackupSchedulerPeriod] $SchedulerPeriod, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Time of day (24 hour in form 23:59)')] [string] $TimeOfDay, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Backup Scheduler')] [PSCustomObject] $VPGSettingBackupScheduler
    )
    
    if (-not $VPGSettingBackupScheduler) {
        if (-not ($TimeOfDay -match "^\d\d:\d\d$") ) {
            throw "Time Of Day must be in the form '23:59'" 
        }
        if ( ($TimeOfDay.Split(':')[0] -lt 0 ) `
                -OR ($TimeOfDay.Split(':')[0] -gt 23 ) `
                -OR ($TimeOfDay.Split(':')[1] -lt 0 ) `
                -OR ($TimeOfDay.Split(':')[1] -gt 59 )  ) {
            throw "Time Of Day must be in the form '00:00' through '23:59'" 
        }


        [ZertoVPGSettingBackupScheduler] $NewObj = [ZertoVPGSettingBackupScheduler]::New($DayOfWeek, $SchedulerPeriod, $TimeOfDay);
    }
    else {
        if (-not ($VPGSettingBackupScheduler.TimeOfDay -match "^\d\d:\d\d$") ) {
            throw "Time Of Day must be in the form '23:59'" 
        }
        if ( ($VPGSettingBackupScheduler.TimeOfDay.Split(':')[0] -lt 0 ) `
                -OR ($VPGSettingBackupScheduler.TimeOfDay.Split(':')[0] -gt 23 ) `
                -OR ($VPGSettingBackupScheduler.TimeOfDay.Split(':')[1] -lt 0 ) `
                -OR ($VPGSettingBackupScheduler.TimeOfDay.Split(':')[1] -gt 59 )  ) {
            throw "Time Of Day must be in the form '00:00' through '23:59'" 
        }
        [ZertoVPGSettingBackupScheduler] $NewObj = [ZertoVPGSettingBackupScheduler]::New($VPGSettingBackupScheduler)
    }

    Return $NewObj        
}