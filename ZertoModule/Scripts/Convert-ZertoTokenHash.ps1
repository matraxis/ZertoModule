Function Convert-ZertoTokenHash {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Zerto Token')] [System.Object] $ZertoToken
    )
    #Saving the token to the ENV as json has to be converted back to hashtable
    if ($ZertoToken -is [String]) {
        try {
            $ZertoToken = $ZertoToken | ConvertFrom-Json
        }
        catch {
            Throw "Invalid Zerto Token - '$ZertoToken'"
        }
    }
    #Round tripping the ZertoToken Hashtable to JSON returns it as a PSCustomObject
    #This converts it back to a hash table from either JSON or string
    if ($ZertoToken -is [PSCustomObject]) {
        $NewHash = @{ }
        $ZertoToken.PSObject.Properties | ForEach-Object {
            $NewHash.Add($_.Name, $_.Value)
        }
        Return $NewHash
    }
    #Already a hash table
    if ($ZertoToken -is [HashTable]) {
        Return $ZertoToken
    }
    Throw "Invalid Zerto Token - '$ZertoToken'"
}