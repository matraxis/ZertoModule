Function New-ZertoVPGSettingBackupRetry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="Individual", HelpMessage  = 'Number of minutes to wait on failure to retry backup')] [int] $IntervalInMinutes, 
        [Parameter(Mandatory=$true, ParameterSetName="Individual", HelpMessage  = 'Number of retries')] [int] $Number, 
        [Parameter(Mandatory=$true, ParameterSetName="Individual", HelpMessage  = 'Retry the backup if it fails')] [bool] $Retry, 
        [Parameter(Mandatory=$true, ParameterSetName="PSObject", HelpMessage  = 'VPGSetting Backup Retry')] [PSCustomObject] $VPGSettingBackupRetry
    )
    
    if (-not $VPGSettingBackupRetry) {
        if ($Number -lt 1) { throw "Number of Retries must be more than 1" }
        if ($IntervalInMinutes -lt 1) { throw "Retry Interval must be more than 1" }
        [ZertoVPGSettingBackupRetry] $NewObj = [ZertoVPGSettingBackupRetry]::New($IntervalInMinutes, $Number, $Retry);
    } else {
        if ($VPGSettingBackupRetry.Number -lt 1) { throw "Number of Retries must be more than 1" }
        if ($VPGSettingBackupRetry.IntervalInMinutes -lt 1) { throw "Retry Interval must be more than 1" }
        [ZertoVPGSettingBackupRetry] $NewObj = [ZertoVPGSettingBackupRetry]::New($VPGSettingBackupRetry)
    }

    Return $NewObj
}