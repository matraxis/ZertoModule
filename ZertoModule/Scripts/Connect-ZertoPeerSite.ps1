Function Connect-ZertoPeerSite {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false, 
            HelpMessage = 'Zerto Server or ENV:\ZertoServer'
        )] 
        [string] 
        $ZertoServer = ( Get-EnvZertoServer ),

        [Parameter(
            Mandatory = $false, 
            HelpMessage = 'Zerto Server URL Port'
        )]
        [string] 
        $ZertoPort = ( Get-EnvZertoPort ),

        [Parameter(
            Mandatory = $false, 
            ValueFromPipeline = $true,
            HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken'
        )] 
        [ValidateNotnullorempty]
        [Hashtable] 
        $ZertoToken = ( Get-EnvZertoToken ),

        [Parameter(
            Mandatory = $true,
            ParameterSetName = "Post",
            HelpMessage = 'Address or DNS name of new site'
        )] 
        [ValidateNotnullorempty]
        [string]
        $HostName,

        [Parameter(
            Mandatory = $false,
            ParameterSetName = "Post",
            HelpMessage = 'The default port used for communication between paired Zerto Virtual Managers. The default port is 9081.'
        )] 
        [ValidateRange(0, 65536)]
        [int] 
        $Port = 9081
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/v1/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    If (-Not (Test-Connection $HostName -Count 1 -Quiet) ) {
        Write-Warning -Message "Could not ping '$hostname'"
    }
    $FullURL = $baseURL + "peersites"
    Write-Verbose $FullURL
    $BodyHash = [ordered] @{ }
    $BodyHash.Add("HostName", $HostName)
    $BodyHash.Add("Port", $Port)
    $BodyJson = $BodyHash | ConvertTo-Json -Depth 20
    Write-Debug -Message "`$BodyJson: `n $BodyJson"
    try {
        $Result = Invoke-RestMethod -Uri $FullURL -TimeoutSec 100 -Headers $ZertoToken -ContentType $TypeJSON -Method Post -Body $BodyJson
    }
    catch {
        Test-RESTError -err $_
    }
    return $Result
}
# .
