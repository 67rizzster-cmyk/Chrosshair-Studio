$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$app = Join-Path $root "CrosshairStudio"
$iss = Join-Path $root "Installer\CrosshairStudio.iss"

$msbuild = Get-Command msbuild.exe -ErrorAction SilentlyContinue
if (-not $msbuild) {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (Test-Path $vswhere) {
        $install = & $vswhere -latest -products * -requires Microsoft.Component.MSBuild -property installationPath
        if ($install) { $msbuild = Join-Path $install "MSBuild\Current\Bin\MSBuild.exe" }
    }
}
if (-not $msbuild) { throw "MSBuild not found. Install Visual Studio/Build Tools with .NET Framework desktop build tools." }
& $msbuild (Join-Path $app "CrosshairStudio.csproj") /t:Build /p:Configuration=Release

$iscc = Get-Command ISCC.exe -ErrorAction SilentlyContinue
if (-not $iscc) {
    foreach ($c in @("$env:ProgramFiles(x86)\Inno Setup 6\ISCC.exe","$env:ProgramFiles\Inno Setup 6\ISCC.exe")) {
        if (Test-Path $c) { $iscc = $c; break }
    }
}
if (-not $iscc) { throw "Inno Setup 6 not found. Install it, then run this script again." }
& $iscc $iss
Write-Host "DONE: Installer\installer\Crosshair-Studio-Setup.exe"
