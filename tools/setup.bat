;@Findstr -bv ;@F "%~f0" | powershell -Command - & pause & goto:eof

# Unzip backwards compatibility (Windows 8)
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip {
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$client = New-Object Net.WebClient

Write-Output "=> Downloading HEMTT (Windows) ...`n"
$client.DownloadFile("https://ci.appveyor.com/api/buildjobs/w02cqm8vq7rhjpy6/artifacts/target%2Fx86_64-pc-windows-msvc%2Frelease%2Fhemtt.exe", "..\hemtt.exe")
$client.dispose()

Write-Output "HEMTT successfully installed to project!`n"
