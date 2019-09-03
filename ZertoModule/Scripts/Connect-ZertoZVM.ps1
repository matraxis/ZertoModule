Function Connect-ZertoZVM {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true, 
            HelpMessage = 'Zerto Server or ENV:\ZertoServer'
        )] 
        [string] 
        $ZertoServer,

        [Parameter(
            Mandatory = $false, 
            HelpMessage = 'Zerto Server URL Port'
        )] 
        [validateRange(0, 65536)]
        [int]
        $ZertoPort = 9669,

        [Parameter(
            Mandatory = $true, 
            HelpMessage = 'User to connect to Zerto'
        )] 
        [PSCredential] 
        $Credential
    )
    Write-Verbose -Message "Setting environment variable for Server"
    Set-Item ENV:ZertoServer $ZertoServer
    Write-Verbose -Message "Setting environment variable for Port"
    Set-Item ENV:ZertoPort $ZertoPort
    Write-Verbose -Message "Setting environment variable for Token"
    Set-Item ENV:ZertoToken ((Get-ZertoAuthToken -ZertoServer $ZertoServer -ZertoPort $ZertoPort -Credential $Credential) | ConvertTo-Json -Compress)
    Write-Verbose -Message "Setting environment variable for Version"
    Set-Item ENV:ZertoVersion (Get-ZertoLocalSite).version
}