Function Get-ZertoVPGCheckpoint {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier,
        [Parameter(Mandatory = $True, ParameterSetName = "ID", HelpMessage = 'Zerto VPG Checkpoint Identifier')] [string] $ZertoVpgCheckpointIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Checkpoint Start Date (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS)')] [string] $StartDate,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Checkpoint End Date (YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS)')] [string] $EndDate
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
        throw "Missing Zerto VPG Identifier"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            if ([string]::IsNullOrEmpty($ZertoVpgCheckpointIdentifier)  ) {
                throw "Missing Zerto VPG Checkpoint Identifier"
            }
            $FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier + "/checkpoints"
        }
        Default {
            $FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier + "/checkpoints"
            if ($StartDate -or $EndDate ) {
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
    #Filter by ID if needed
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            $Result = $Result | Where-Object { $_.CheckpointIdentifier -eq $ZertoVpgCheckpointIdentifier }
        }
        Default {
        }
    }
    return $Result
}
# .
