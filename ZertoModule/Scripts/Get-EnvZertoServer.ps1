Function Get-EnvZertoServer {
    If ( (Get-Item Env:\ZertoServer -ErrorAction SilentlyContinue) ) {
        return (Get-Item Env:\ZertoServer).Value
    }
}