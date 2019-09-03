Function Get-ZertoVPGCheckpointSummary {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Identifier')] [string] $ZertoVpgIdentifier
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoVpgIdentifier)  ) {
        throw "Missing Zerto VPG Identifier"
    }
    $FullURL = $baseURL + "vpgs/" + $ZertoVpgIdentifier + "/checkpoints/Summary"
    Write-Verbose $FullURL
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON
    }
    catch {
        Test-RESTError -err $_
    }
    #Show depricated if 5.0u2 or higher
    try {
        switch ( [Version] $env:ZertoVersion) {
            { $_ -ge [Version]::new("5.0.21") }
            { #5.0u2
                Write-Warning "Get-ZertoVPGCheckpointSummary is depricated as of Zerto 5.0u2.  Use Get-Get-ZertoVPGCheckpointStats."  
            }
            5.0.12 {  
            }
            #5.0u1
            Default {
            }
        }
    }
    catch {
        Write-Warning "Invalid ZertoVersion: $env:ZertoVersion "
    }
    return $Result
}
# .
