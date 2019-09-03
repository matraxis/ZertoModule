[CmdletBinding()]
$Scripts = @( Get-ChildItem -Path $PSScriptRoot\Scripts\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$Classes = Get-ChildItem -Path $PSScriptRoot\Scripts\Setup-class.ps1
. $Classes.fullname
Write-Verbose -Message "The number of scripts seen is $($Scripts.Count)"
#$Tests = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Recurse -ErrorAction SilentlyContinue )
Foreach($import in @($Scripts)) {
    Write-Verbose -Message "Importing module $Import."
    . $import.fullname
}

Export-ModuleMember -Function * -Cmdlet * -Alias *