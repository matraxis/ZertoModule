Function Get-ZertoAlert {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Alert Start Date (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS)')] [string] $StartDate,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Alert End Date (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS)')] [string] $EndDate,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VPG Identifier')] [string] $VPGIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto ZORG Identifier')] [string] $ZORGIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Site Identifier')] [string] $SiteIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Alert Level')] [ZertoAlertLevel] $Level,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Alert Entity')] [ZertoAlertEntity] $Entity,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Alert HelpIdentifier')] [ZertoAlertHelpIdentifier] $HelpIdentifier,
        [Parameter(Mandatory = $true, ParameterSetName = "ID", HelpMessage = 'Zerto Alert Identifier')] [string] $ZertoAlertIdentifier
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            if ([string]::IsNullOrEmpty($ZertoAlertIdentifier)  ) {
                throw "Missing Zerto Alert Identifier"
            }
            $FullURL = $baseURL + "alerts/" + $ZertoAlertIdentifier
        }
        Default {
            $FullURL = $baseURL + "alerts"
            if ($StartDate -or $EndDate -or $VPGIdentifier -or $ZORGIdentifier -or $SiteIdentifier -or $Level -ne $null -or $Entity -ne $null -or $HelpIdentifier -ne $null) {
                $qs = [ordered] @{ }
                if ($StartDate) {
                    if (Parse-ZertoDate($StartDate)) {
                        $qs.Add("StartDate", $StartDate) 
                    }
                    else {
                        throw "Invalid StartDate: '$StartDate'" 
                    } 
                }
                if ($EndDate) {
                    if (Parse-ZertoDate($EndDate)) {
                        $qs.Add("EndDate",
                            $EndDate)
                    }
                    else {
                        throw "Invalid EndDate: '$EndDate'" 
                    } 
                }
                if ($VPGIdentifier) {
                    $qs.Add("VPGIdentifier", $VPGIdentifier) 
                }
                if ($ZORGIdentifier) {
                    $qs.Add("ZORGIdentifier", $ZORGIdentifier) 
                }
                if ($SiteIdentifier) {
                    $qs.Add("SiteIdentifier", $SiteIdentifier) 
                }
                if ($Level -ne $null) {
                    $qs.Add("Level", $Level) 
                }
                if ($Entity -ne $null) {
                    $qs.Add("Entity", $Entity) 
                }
                if ($HelpIdentifier -ne $null) {
                    $qs.Add("HelpIdentifier", $HelpIdentifier) 
                }
                $FullURL += Get-QueryStringFromHashTable -QueryStringHash $QS
            }
        }
    }
    Write-Verbose $FullURL
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
# .
