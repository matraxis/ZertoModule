Function StringOrNull {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'String')][AllowEmptyString()] [string] $ThisString
    )
    if ([String]::IsNullOrEmpty($ThisString) ) {
        Return  [NullString]::Value ;
    }
    else {
        Return $ThisString;
    }
}  #endregion  #region Zerto Authentication