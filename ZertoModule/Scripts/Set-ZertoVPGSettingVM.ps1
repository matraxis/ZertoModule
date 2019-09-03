Function Set-ZertoVPGSettingVM {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Settings Identifier')] [string] $ZertoVpgSettingsIdentifier,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Settings VM ID')] [string] $ZertoVPGSettingVMID,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto VPG Settings VM object')] [ZertoVPGSettingVM] $ZertoVPGSettingVM
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ([string]::IsNullOrEmpty($ZertoVpgSettingsIdentifier)  ) {
        throw "Missing Zerto VPG Settings Identifier"
    }
    $FullURL = $baseURL + "vpgSettings/" + $ZertoVpgSettingsIdentifier + "/VMs/" + $ZertoVPGSettingVMID
    Write-Verbose $FullURL
    $Body = $ZertoVPGSettingVM | ConvertTo-Json -Depth 10
    Write-Verbose $Body
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Put -Body $Body
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
# .
