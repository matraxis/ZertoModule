Function Parse-ZertoDate {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Zerto Date in the form YYYY-MM-DD or YYYY-MM-DDThh:mm:ss')] [String] $ZertoDate
    )
    try {
        $out = [DateTime]::Parse($ZertoDate) | Out-Null
        Return $True
    }
    catch {
        Return $False
    }
}