# Build Flutter web for itch.io
Set-Location $PSScriptRoot

flutter build web --no-tree-shake-icons --release
if ($LASTEXITCODE -ne 0) { Write-Host "BUILD FAILED"; exit 1 }

# Run patch script (removes audio, fixes base href, fixes bootstrap, repackages)
.\patch_web.ps1
