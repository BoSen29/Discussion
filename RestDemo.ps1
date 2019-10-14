Import-Module C:\temp\dev\universal-dashboard\src\output\UniversalDashboard.psm1

get-uddashboard | Stop-UDDashboard

Enable-UDLogging -Level "Debug" -FilePath "C:\temp\dev\testdash\verbose.txt"

$Endpoint = New-UDEndpoint -Url "/process" -Method "POST" -Endpoint {
    param($File)
    Write-UDLog "GOT A FILE!"
    $filestream = [IO.File]::Create("c:\temp\dev\testdash\stuff.txt")
    $stream = $File.OpenReadStream()
    $stream.CopyTo($filestream)
    $fileStream.Dispose()
    $stream.Dispose()
    Write-UDLog "POST REQUEST reccieved"

}
Start-UDRestApi -Endpoint $Endpoint -Port 8083
