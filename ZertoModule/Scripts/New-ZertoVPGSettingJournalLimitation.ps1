Function New-ZertoVPGSettingJournalLimitation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'HardLimitInMB')] [int] $HardLimitInMB = 153600,
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'HardLimitInPercent')] [int] $HardLimitInPercent, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'WarningThresholdInMB')] [int] $WarningThresholdInMB = 115200, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'WarningThresholdInPercent')] [int] $WarningThresholdInPercent, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Journal Limitation')] [PSCustomObject] $VPGSettingJournalLimitation
    )
    
    if (-not $VPGSettingJournalLimitation) {
        if ( $HardLimitInMB -lt 0 ) {
            throw "HardLimitInMB must be greather then 0 - '$HardLimitInMB'"
        }
        if ( ($HardLimitInPercent -lt 0) -or ($HardLimitInPercent -gt 100 ) ) {
            throw "HardLimitInPercent must be between 0 and 100  - '$HardLimitInPercent'"
        }
        if ( $WarningThresholdInMB -lt 0 ) {
            throw "WarningThresholdInMB must be greather then 0 - '$WarningThresholdInMB'"
        }
        if ( ($WarningThresholdInPercent -lt 0) -or ($WarningThresholdInPercent -gt 100 ) ) {
            throw "WarningThresholdInPercent must be between 0 and 100  - '$WarningThresholdInPercent'"
        }
        [ZertoVPGSettingJournalLimitation] $NewObj = [ZertoVPGSettingJournalLimitation]::New($HardLimitInMB, $HardLimitInPercent, $WarningThresholdInMB, $WarningThresholdInPercent);
    }
    else {
        if ( $VPGSettingJournalLimitation.HardLimitInMB -lt 0 ) {
            throw "HardLimitInMB must be greather then 0 - '$VPGSettingJournalLimitation.HardLimitInMB'"
        }
        if ( ($VPGSettingJournalLimitation.HardLimitInPercent -lt 0) -or ($VPGSettingJournalLimitation.HardLimitInPercent -gt 100 ) ) {
            throw "HardLimitInPercent must be between 0 and 100  - '$VPGSettingJournalLimitation.HardLimitInPercent'"
        }
        if ( $VPGSettingJournalLimitation.WarningThresholdInMB -lt 0 ) {
            throw "WarningThresholdInMB must be greather then 0 - '$VPGSettingJournalLimitation.WarningThresholdInMB'"
        }
        if ( ($VPGSettingJournalLimitation.WarningThresholdInPercent -lt 0) -or ($VPGSettingJournalLimitation.WarningThresholdInPercent -gt 100 ) ) {
            throw "WarningThresholdInPercent must be between 0 and 100  - '$VPGSettingJournalLimitation.WarningThresholdInPercent'"
        }
        [ZertoVPGSettingJournalLimitation] $NewObj = [ZertoVPGSettingJournalLimitation]::New($VPGSettingJournalLimitation)
    }

    Return $NewObj        
}