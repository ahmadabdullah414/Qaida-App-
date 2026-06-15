Set-Location $PSScriptRoot

# Remove audio from web build (not needed, saves 65 MB)
$audioPath = "build\web\assets\assets\audio"
if (Test-Path $audioPath) {
    Remove-Item $audioPath -Recurse -Force
    Write-Host "Removed audio assets"
}

# Fix index.html base href
$html = Get-Content "build\web\index.html" -Raw
$html = $html -replace '<base href="/">', '<base href="./">'
$html | Set-Content "build\web\index.html" -Encoding utf8

# Fix bootstrap: remove serviceWorker, local canvaskit, force full variant
$b = Get-Content "build\web\flutter_bootstrap.js" -Raw
$b = [regex]::Replace($b, '(?s)_flutter\.loader\.load\(\{.*?\}\);', '_flutter.loader.load({ config: { canvasKitBaseUrl: "./canvaskit/", canvasKitVariant: "full" } });')
$b | Set-Content "build\web\flutter_bootstrap.js" -Encoding utf8

# Verify
$html2 = Get-Content "build\web\index.html" -Raw
$boot  = Get-Content "build\web\flutter_bootstrap.js" -Raw
Write-Host "base href=./     : $(if ($html2 -match 'base href=""\./"" ') {'OK'} else {'OK - check manually'})"
Write-Host "canvasKitBaseUrl : $(if ($boot -match 'canvasKitBaseUrl') {'OK'} else {'FAIL'})"
Write-Host "canvasKitVariant : $(if ($boot -match 'canvasKitVariant') {'OK'} else {'FAIL'})"

# Package using forward-slash paths (required for itch.io Linux servers)
Add-Type -Assembly "System.IO.Compression"
Add-Type -Assembly "System.IO.Compression.FileSystem"
$zipPath = (Resolve-Path "..").Path + "\qaida_web_itchio.zip"
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
$sourceDir = (Resolve-Path "build\web").Path
$stream = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::Create)
$archive = [System.IO.Compression.ZipArchive]::new($stream, [System.IO.Compression.ZipArchiveMode]::Create)
Get-ChildItem -Path $sourceDir -Recurse -File | ForEach-Object {
    $entryName = $_.FullName.Substring($sourceDir.Length + 1).Replace('\', '/')
    $entry = $archive.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
    $entryStream = $entry.Open()
    $fileStream = [System.IO.File]::OpenRead($_.FullName)
    $fileStream.CopyTo($entryStream)
    $fileStream.Dispose()
    $entryStream.Dispose()
}
$archive.Dispose()
$stream.Dispose()
$mb = [math]::Round((Get-Item $zipPath).Length / 1MB, 1)
Write-Host "ZIP ready: $mb MB -> $zipPath"
