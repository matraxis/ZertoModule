Function Get-ZertoVPG {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VPG Name')] [string] $VPGName,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VPG Status')] [ZertoVPGStatus] $Status,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VPG Status')] [ZertoVPGSubStatus] $SubStatus,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Protected Site Type')] [ZertoProtectedSiteType] $ProtectedSiteType,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Recovery Site Type')] [ZertoRecoverySiteType] $RecoverySiteType,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Protected Site Identifier')] [string] $ProtectedSiteIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Recovery Site Identifier')] [string] $RecoverySiteIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto ZOrg Name')] [string] $ZOrganizationName,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto ZOrg Identifier')] [string] $ZOrgIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VPG Priority')] [string] $Priority,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Service Profile Identifier')] [string] $ServiceProfileIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VPG Backup Enabled ')] [boolean] $BackupEnabled,
        [Parameter(Mandatory = $true, ParameterSetName = "ID", HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
                throw "Missing Zerto VPG Identifier"
            }
            $FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier
        }
        Default {
            $FullURL = $baseURL + "vpgs"
            if ($VPGName -or $Status -ne $null -or $SubStatus -ne $null -or $ProtectedSiteType -ne $null `
                    -or $RecoverySiteType -ne $null -or $ProtectedSiteIdentifier -or `
                    $RecoverySiteIdentifier -or $ZOrganizationName -or $ZOrgIdentifier `
                    -or $priority -ne $null -or $serviceProfileIdentifier -or $backupEnabled ) {
                $qs = [ordered] @{ }
                if ($VPGName) {
                    $qs.Add("Name", $VPGName) 
                }
                if ($Status -ne $null) {
                    $qs.Add("Status", $Status) 
                }
                if ($SubStatus -ne $null) {
                    $qs.Add("SubStatus", $SubStatus) 
                }
                if ($ProtectedSiteType -ne $null) {
                    $qs.Add("ProtectedSiteType", $ProtectedSiteType) 
                }
                if ($RecoverySiteType -ne $null) {
                    $qs.Add("RecoverySiteType", $RecoverySiteType) 
                }
                if ($ProtectedSiteIdentifier) {
                    $qs.Add("ProtectedSiteIdentifier", $ProtectedSiteIdentifier) 
                }
                if ($RecoverySiteIdentifier) {
                    $qs.Add("RecoverySiteIdentifier", $RecoverySiteIdentifier) 
                }
                if ($ZOrganizationName) {
                    $qs.Add("ZOrganizationName", $ZOrganizationName) 
                }
                if ($ZOrgIdentifier) {
                    $qs.Add("ZOrgIdentifier", $ZOrgIdentifier) 
                }
                if ($Priority -ne $null) {
                    $qs.Add("priority", $Priority) 
                }
                if ($ServiceProfileIdentifier) {
                    $qs.Add("ServiceProfileIdentifier", $ServiceProfileIdentifier) 
                }
                if ($BackupEnabled) {
                    $qs.Add("BackupEnabled", $BackupEnabled) 
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
