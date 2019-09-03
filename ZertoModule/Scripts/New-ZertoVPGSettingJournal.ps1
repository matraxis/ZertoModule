Function New-ZertoVPGSettingJournal {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DatastoreClusterIdentifier')] [string] $DatastoreClusterIdentifier, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'DatastoreIdentifier')] [string] $DatastoreIdentifier, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'VPG Setting Journal Limitation object')] [ZertoVPGSettingJournalLimitation] $Limitation, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Journal ')] [PSCustomObject] $VPGSettingJournal
    )
    
    if (-not $VPGSettingJournal) {
        [ZertoVPGSettingJournal] $NewObj = [ZertoVPGSettingJournal]::New($DatastoreClusterIdentifier, $DatastoreIdentifier, $Limitation);
    }
    else {
        [ZertoVPGSettingJournal] $NewObj = [ZertoVPGSettingJournal]::New($VPGSettingJournal)
    }

    Return $NewObj
}