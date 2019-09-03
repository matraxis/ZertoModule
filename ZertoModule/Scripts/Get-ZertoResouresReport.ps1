Function Get-ZertoResouresReport {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Report From Time (YYYY-MM-DD HH:MM:SS)')] [string] $FromTime,
        [Parameter(Mandatory = $true, HelpMessage = 'Zerto Report To Time (YYYY-MM-DD HH:MM:SS)')] [string] $ToTime,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Report Start Index ')] [string] $StartIndex,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Report Records to retrieve 1 to 500')] [string] $Count = 500
    )
    $baseURL = "https://" + $ZertoServer + ":" + $ZertoPort + "/ZvmService/ResourcesReport/"
    $TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    if ($Count -lt 1 -or $Count -gt 500) {
        throw "Invalid Count - must be from 1 to 500"
    }
    $FullURL = $baseURL + "getSamples"
    if ($FromTime -or $ToTime -or $StartIndex -or $Count ) {
        $qs = [ordered] @{ }
        if ($FromTime) {
            if (Parse-ZertoDate($FromTime)) {
                $qs.Add("fromTimeString", $FromTime) 
            }
            else {
                throw "Invalid FromTime: '$FromTime'" 
            } 
        }
        if ($ToTime) {
            if (Parse-ZertoDate($ToTime)) {
                $qs.Add("toTimeString",
                    $ToTime)
            }
            else {
                throw "Invalid ToTime: '$ToTime'" 
            } 
        }
        if ($StartIndex) {
            $qs.Add("startIndex",
                $StartIndex)  
        }
        if ($Count) {
            $qs.Add("count", $Count) 
        }
        $FullURL += Get-QueryStringFromHashTable -QueryStringHash $QS
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
