Function Get-ZertoVRA {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Name')] [string] $VRAName,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Status')] [ZertoVRAStatus] $VRAStatus,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Version')] [string] $VRAVersion,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto Host Version')] [string] $HostVersion,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA IP Address')] [string] $IPAddress,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Group')] [string] $VRAGroup,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Datastore Name')] [string] $DatastoreName,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Datastore Cluster Name')] [string] $DatastoreClusterName,
        [Parameter(Mandatory = $false, ParameterSetName = "Filter", HelpMessage = 'Zerto VRA Network Name')] [string] $NetworkName,
        [Parameter(Mandatory = $true, ParameterSetName = "ID", HelpMessage = 'Zerto VRA Identifier')] [string] $ZertoVraIdentifier
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            if ([string]::IsNullOrEmpty($ZertoVraIdentifier)  ) {
                throw "Missing Zerto VRA Identifier"
            }
            $FullURL = $baseURL + "vras"
        }
        Default {
            $FullURL = $baseURL + "vras"
            if ($VRAName -or $VRAStatus -ne $null -or $VRAVersion -or $HostVersion -or $IPAddress `
                    -or $VRAGroup -or $DatastoreName -or $DatastoreClusterName -or $NetworkName ) {
                $qs = [ordered] @{ }
                if ($VRAName) {
                    $qs.Add("VRAName", $VRAName) 
                }
                if ($VRAStatus -ne $null) {
                    $qs.Add("Status", $VRAStatus) 
                }
                if ($VRAVersion) {
                    $qs.Add("VRAVersion", $VRAVersion) 
                }
                if ($HostVersion) {
                    $qs.Add("HostVersion", $HostVersion) 
                }
                if ($IPAddress) {
                    $qs.Add("IPAddress", $IPAddress) 
                }
                if ($VRAGroup) {
                    $qs.Add("VRAGroup", $VRAGroup) 
                }
                if ($DatastoreName) {
                    $qs.Add("DatastoreName", $DatastoreName) 
                }
                if ($DatastoreClusterName) {
                    $qs.Add("DatastoreClusterName", $DatastoreClusterName) 
                }
                if ($NetworkName) {
                    $qs.Add("type", $NetworkName) 
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
            $Result = $Result | Where-Object { $_.VraIdentifier -eq $ZertoVraIdentifier }
        }
        Default {
        }
    }
    return $Result
}
# .
