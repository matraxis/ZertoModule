Function Test-RESTError {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = 'Error')] [System.Management.Automation.ErrorRecord] $err
    )
    If ($err.Exception -is [System.Net.WebException]) {
        If ($err.Exception.Response.StatusCode.value__ -eq 500) {
            $stream = $err.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd();
            $obj = $responseBody | ConvertFrom-Json
            if ($obj.Message) {
                throw $obj.Message
            }
            else {
                throw $obj
            }
        }
        else {
            throw "Unknown web error: " + $err.Exception.Response.StatusCode.value__ + " : " + $err.Exception.Response.StatusDescription
        }
    }
    else {
        throw "Unknown error: " + $err.Exception
    }
}