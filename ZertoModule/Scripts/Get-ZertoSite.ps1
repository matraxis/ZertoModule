Function Get-ZertoSite {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $false, ParameterSetName = "ID", HelpMessage = 'Zerto Site Identifier')] [string] $ZertoSiteIdentifier
    )
    switch ($PsCmdlet.ParameterSetName) {
        "ID" {
            Return Get-ZertoVirtualizationSite -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken -ZertoSiteIdentifier $ZertoSiteIdentifier
        }
        Default {
            Return Get-ZertoVirtualizationSite -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken
        }
    }
    if ($ZertoSiteIdentifier) {
    }
    else {
        Return Get-ZertoVirtualizationSite -ZertoServer $ZertoServer -ZertoPort $ZertoPort -ZertoToken $ZertoToken
    }
}
# .
