Function Set-SSLCertByPass () {
    ################################################
    # Setting certificate exception to prevent authentication issues to the ZVM
    ################################################
    try {
        $type = "using System.Net;" + [Environment]::NewLine
        $type += "using System.Security.Cryptography.X509Certificates;" + [Environment]::NewLine
        $type += "public class TrustAllCertsPolicy : ICertificatePolicy {" + [Environment]::NewLine
        $type += "  public bool CheckValidationResult( ServicePoint srvPoint, X509Certificate certificate, WebRequest request, int certificateProblem) {" + [Environment]::NewLine
        $type += "
return true;" + [Environment]::NewLine
        $type += "  }" + [Environment]::NewLine
        $type += "}" + [Environment]::NewLine
        Add-Type -TypeDefinition $type -ErrorAction SilentlyContinue
    }
    catch {
        If ($Error[0].Exception -ne "Cannot add type. The type name 'TrustAllCertsPolicy' already exists.") {
            Write-Debug $Error[0]
        }
    }
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}