Function Get-EnvZertoToken {
    If ((Get-Item Env:\ZertoToken -ErrorAction SilentlyContinue) ) {
        Return Convert-ZertoTokenHash -ZertoToken  (Get-Item Env:\ZertoToken).Value
    }
}