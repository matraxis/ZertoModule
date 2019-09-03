Function New-ZertoVPGSettingScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Command')] [AllowNull()]  [AllowEmptyString()]  [string] $Command, 
        [Parameter(Mandatory = $true, ParameterSetName = "Individual", HelpMessage = 'Parameters')] [AllowNull()]  [AllowEmptyString()] [string] $Parameters, 
        [Parameter(Mandatory = $false, ParameterSetName = "Individual", HelpMessage = 'Timeout In Seconds')] [int] $TimeoutInSeconds = 300, 
        [Parameter(Mandatory = $true, ParameterSetName = "PSObject", HelpMessage = 'VPGSetting Script object')] [PSCustomObject] $VPGSettingScript
    )
    
    if (-not $VPGSettingScript) {
        if ( ($TimeoutInSeconds -lt 300) -or ($TimeoutInSeconds -gt 6000) ) {
            throw "TimeoutInSeconds must be between 300 & 6000 " 
        }
        [ZertoVPGSettingScript] $NewObj = [ZertoVPGSettingScript]::New($Command, $Parameters, $TimeoutInSeconds);
    }
    else {
        if ( ($VPGSettingScript.TimeoutInSeconds -lt 300) -or ($VPGSettingScript.TimeoutInSeconds -gt 6000) ) {
            throw "TimeoutInSeconds must be between 300 & 6000 " 
        }
        [ZertoVPGSettingScript] $NewObj = [ZertoVPGSettingScript]::New($VPGSettingScript)
    }

    Return $NewObj
}