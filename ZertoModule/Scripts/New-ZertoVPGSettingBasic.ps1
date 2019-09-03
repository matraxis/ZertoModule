Function New-ZertoVPGSettingBasic {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Name')] [string] $Name, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Zerto Protected Site Identifier')] [string] $ProtectedSiteIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Zerto Protected Site Identifier')] [string] $RecoverySiteIdentifier, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Journal History In Hours')] [int] $JournalHistoryInHours = 24, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Priority')] [ZertoVPGPriority] $Priority = 'Medium', 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Zerto RPO in Seconds')] [int] $RpoInSeconds = 300, 
        [Parameter(Mandatory = $false , ParameterSetName = "Individual", HelpMessage = 'Zerto Service Profile Identifier')] [string] $ServiceProfileIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Test Interval In Minutes')] [int] $TestIntervalInMinutes = 262080,
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Use Wan Compression')] [Boolean] $UseWanCompression = $true, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Zorg Identifier')] [string] $ZorgIdentifier,
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Basic')] [PSCustomObject] $VPGSettingBasic

    )
    
    if (-not $VPGSettingBasic) {
        if ( $JournalHistoryInHours -lt 1 ) {
            throw "Journal history must be greather then 0 - '$JournalHistoryInHours'"
        }
        if ( $TestIntervalInMinutes -lt 1 ) {
            throw "Test Interval In Minutes must be greather then 0 - '$TestIntervalInMinutes'"
        }
        if ( $RpoInSeconds -lt 1 ) {
            throw "RpoInSeconds  must be greather then 0 - '$RpoInSeconds'"
        }
        [ZertoVPGSettingBasic] $NewObj = [ZertoVPGSettingBasic]::New($JournalHistoryInHours, $Name, $Priority, `
                $ProtectedSiteIdentifier, $RecoverySiteIdentifier, $RpoInSeconds, `
                $ServiceProfileIdentifier, $TestIntervalInMinutes, $UseWanCompression, `
                $ZorgIdentifier );
    }
    else {
        if ( $VPGSettingBasic.JournalHistoryInHours -lt 1 ) {
            throw "Journal history must be greather then 0 - '$VPGSettingBasic.JournalHistoryInHours'"
        }
        if ( $VPGSettingBasic.TestIntervalInMinutes -lt 1 ) {
            throw "Test Interval In Minutes must be greather then 0 - '$VPGSettingBasic.TestIntervalInMinutes'"
        }
        if ( $VPGSettingBasic.RpoInSeconds -lt 1 ) {
            throw "RpoInSeconds  must be greather then 0 - '$VPGSettingBasic.RpoInSeconds'"
        }
        [ZertoVPGSettingBasic] $NewObj = [ZertoVPGSettingBasic]::New($VPGSettingBasic)
    }

    Return $NewObj       
}