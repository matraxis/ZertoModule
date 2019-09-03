Function Start-ZertoVPGFailover {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto VPG Checkpoint Identifier (default is latest)')] [string] $ZertoVpgCheckpointIdentifier,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Commit Policy')] [ZertoCommitPolicy] $CommitPolicy = "Commit",
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Commit Value in seconds')] [string] $CommitInSeconds,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Shutdown Policy')] [ZertoShutdownPolicy] $ShutdownPolicy = "Shutdown",
        [Parameter(Mandatory = $true, HelpMessage = 'Time to wait before shutdown in seconds')] [string] $TimeToWaitBeforeShutdownInSec,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Reverse Protection')] [bool] $ReverseProtection = $true
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
        throw "Missing Zerto VPG Identifier"
    }
    $FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier + "/Failover"
    Write-Verbose $FullURL
    $BodyHash = [ordered] @{ }
    if ($ZertoVpgCheckpointIdentifier) {
        $BodyHash.Add("CheckpointIdentifier", $ZertoVpgCheckpointIdentifier )
    }
    else {
        $BodyHash.Add("CheckpointIdentifier", (Get-ZertoVPGCheckpointLastID -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoVpgIdentifier $ZertoVpgIdentifier )  )
    }
    $BodyHash.Add("CommitPolicy", $CommitPolicy )
    #$Failover.Add("CommitValue", $CommitInSeconds)
    $BodyHash.Add("ShutdownPolicy", $ShutdownPolicy )
    $BodyHash.Add("TimeToWaitBeforeShutdownInSec", $TimeToWaitBeforeShutdownInSec )
    $BodyHash.Add("IsReverseProtection", $ReverseProtection )
    $BodyJson = $BodyHash | ConvertTo-Json
    Write-Verbose $BodyJson
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Post -Body $BodyJson
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
# .
