Function Get-ZertoTaskState {
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param(
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server or ENV:\ZertoServer')] [string] $ZertoServer = ( Get-EnvZertoServer )  ,
        [Parameter(Mandatory = $false, HelpMessage = 'Zerto Server URL Port')] [string] $ZertoPort = ( Get-EnvZertoPort ),
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, HelpMessage = 'Zerto authentication token from Get-ZertoAuthToken or ENV:\ZertoToken')] [Hashtable] $ZertoToken = ( Get-EnvZertoToken ),
        [Parameter(Mandatory = $true, ParameterSetName = "State", HelpMessage = 'Zerto Task State')] [string] $ZertoTaskState,
        [Parameter(Mandatory = $true, ParameterSetName = "ID", HelpMessage = 'Zerto Task State ID')] [ZertoTaskStates] $ZertoTaskStateID
    )
    #$baseURL = "https://" + $ZertoServer + ":"+$ZertoPort+"/v1/"
    #$TypeJSON = "application/json"
    if ( $ZertoToken -eq $null) {
        throw "Missing Zerto Authentication Token"
    }
    switch ($PsCmdlet.ParameterSetName) {
        "State" {
            if ([string]::IsNullOrEmpty($ZertoTaskState)  ) {
                throw "Missing Zerto Task State"
            }
            Return [ZertoTaskStates]::$ZertoTaskState.value__
        }
        "ID" {
            Return [ZertoTaskStates]$ZertoTaskStateID
        }
        Default {
            return [System.Enum]::GetNames([ZertoTaskStates])
        }
    }
}