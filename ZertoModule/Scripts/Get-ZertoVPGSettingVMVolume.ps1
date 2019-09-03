Function Get-ZertoVPGSettingVMVolume {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Settings Identifier')] [string] $ZertoVpgSettingsIdentifier,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VM Identifier')] [string] $ZertoVmIdentifier,
        [Parameter(Mandatory = $false, ParameterSetName = "ID", HelpMessage = 'Zerto VM Volumne Identifier')] [string] $ZertoVMVolumeIdentifier
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoVpgSettingsIdentifier)  ) {
        throw "Missing Zerto VPG Settings Identifier"
    }
    if ([string]::IsNullOrEmpty($ZertoVmIdentifier)  ) {
        throw "Missing Zerto VM Identifier"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            if ([string]::IsNullOrEmpty($ZertoVMVolumeIdentifier)  ) {
                throw "Missing Zerto Volume Identifier"
            }
            $FullURL = $baseURL + "vpgSettings/" + $ZertoVpgSettingsIdentifier + "/vms/" + $ZertoVmIdentifier + "/volumes/" + $ZertoVMVolumeIdentifier
        }
        Default {
            $FullURL = $baseURL + "vpgSettings/" + $ZertoVpgSettingsIdentifier + "/vms/" + $ZertoVmIdentifier + "/volumes"
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
