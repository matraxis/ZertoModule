Function Get-EnvZertoPort {
    If ((Get-Item Env:\ZertoPort -ErrorAction SilentlyContinue) ) {
        Return (Get-Item Env:\ZertoPort).Value
    }
    else {
        Return '9669'
    }
}