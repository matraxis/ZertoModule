Function Get-QueryStringFromHashTable {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Query String Hash Table')] [Hashtable] $QueryStringHash
    )
    $out = ""
    $QueryStringHash.keys | ForEach-Object {
        if ($Out.Length -eq 0 ) {
            $Out += "?"
        }
        else {
            $Out += "&"
        }
        # HTML Encode???
        $Out += $_ + "=" + $QueryStringHash[$_]
    }
    Return $Out
}