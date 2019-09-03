Function Get-ZertoVPGStatus {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, ParameterSetName = "Status", HelpMessage = 'Zerto VPG Status')] [string] $ZertoVPGStatus,
        [Parameter(Mandatory = $true, ParameterSetName = "ID", HelpMessage = 'Zerto VPG Status ID')] [ZertoVPGStatus] $ZertoVPGStatusID
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "Status" {
            if ([string]::IsNullOrEmpty($ZertoVPGStatus)  ) {
                throw "Missing Zerto VPG Status"
            }
            Return [ZertoVPGStatus]::$ZertoVPGStatus.value__
        }
        "ID" {
            Return [ZertoVPGStatus]$ZertoVPGStatusID
        }
        Default {
            #return [System.Enum]::GetNames([ZertoVPGStatus])
            $FullURL = $baseURL + "vpgs/statuses"
            Write-Verbose $FullURL
            try {
                $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON
            }
            catch {
                Test-RESTError -err $_
            }
            return $Result
        }
    }
}
# .
