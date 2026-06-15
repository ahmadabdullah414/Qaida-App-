# Build Flutter web for itch.io
Set-Location $PSScriptRoot

flutter build web --web-renderer canvaskit --no-tree-shake-icons --release
if ($LASTEXITCODE -ne 0) { Write-Host "BUILD FAILED"; exit 1 }

# Fix index.html - base href must be "./" for itch.io
(Get-Content "build\web\index.html" -Raw) -replace '<base href="/">', '<base href="./">' |
    Set-Content "build\web\index.html" -Encoding utf8

# Fix flutter_bootstrap.js - replace the entire loader.load() call
$b = Get-Content "build\web\flutter_bootstrap.js" -Raw
# Remove serviceWorkerSettings and add local canvaskit + force full variant
$b = [regex]::Replace($b,
    '_flutter\.loader\.load\(\{[^;]*\}\);',
    '_flutter.loader.load({ config: { canvasKitBaseUrl: "./canvaskit/", canvasKitVariant: "full" } });')
$b | Set-Content "build\web\flutter_bootstrap.js" -Encoding utf8

# Verify
$html = Get-Content "build\web\index.html" -Raw
$boot = Get-Content "build\web\flutter_bootstrap.js" -Raw
Write-Host "base href .:   $(if ($html -match 'base href=""\./"" ') {'OK'} else {'CHECK'})"
Write-Host "canvasKitBase: $(if ($boot -match 'canvasKitBaseUrl') {'OK'} else {'MISSING'})"
Write-Host "variant full:  $(if ($boot -match 'canvasKitVariant.*full') {'OK'} else {'MISSING'})"
Write-Host "no svcWorker:  $(if ($boot -notmatch 'serviceWorkerVersion.*:') {'OK'} else {'still there'})"

Compress-Archive -Path "build\web\*" -DestinationPath "..\qaida_web_itchio.zip" -Force
Write-Host "ZIP: $([math]::Round((Get-Item '..\qaida_web_itchio.zip').Length/1MB,1)) MB -> D:\qaida_web_itchio.zip"
