# VsDevCmd-to-Path.ps1
# Version: 3.0.0
# https://github.com/reallukee/vsdevcmd-to-path

param (
    [ValidateSet(
        "Status",
        "Add",
        "Remove"
    )]
    [string] $Command,

    [ValidateSet(
        "User",
        "Machine"
    )]
    [string] $Environment,

    [ValidateSet(
        "2026",
        "2022",
        "2019",
        "2017",
        "2015"
    )]
    [string] $Release,

    [switch] $Version,
    [switch] $Help,
    [switch] $About,

    [switch] $NoDump,

    [switch] $Silent
)



function Write-Output-Info {
    param (
        [string] $Message
    )

    if ($Silent) {
        return
    }

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host -Message "`e[32m[INFO] ${Message}`e[0m"
    } else {
        Write-Host -Message "[INFO] ${Message}"
    }
}

function Write-Output-Warn {
    param (
        [string] $Message
    )

    if ($Silent) {
        return
    }

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host -Message "`e[33m[WARN] ${Message}`e[0m"
    } else {
        Write-Host -Message "[WARN] ${Message}"
    }
}

function Write-Output-Fail {
    param (
        [string] $Message
    )

    if ($Silent) {
        return
    }

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host -Message "`e[31m[FAIL] ${Message}`e[0m"
    } else {
        Write-Host -Message "[FAIL] ${Message}"
    }
}



function Get-Release-Range {
    param (
        [string] $Release
    )

    switch ($Release) {
        "2026" { return "[18.0, 19.0)"; }
        "2022" { return "[17.0, 18.0)"; }
        "2019" { return "[16.0, 17.0)"; }
        "2017" { return "[15.0, 16.0)"; }
        "2015" { return "[14.0, 15.0)"; }
    }
}

function Get-Visual-Studio {
    param (
        [string] $Release
    )

    $releaseRange = Get-Release-Range -Release $Release

    if ($Release -eq "2015") {
        $path = . $VSWhere -legacy `
                           -version $releaseRange `
                           -property installationPath
    }
    else {
        $path = & $VSWhere -version $ReleaseRange `
                           -requires "Microsoft.Component.MSBuild" `
                           -property installationPath
    }

    $devCmdExists = $false

    if ($path) {
        $devCmdPath = "${path}\Common7\Tools"

        if (Test-Path -Path $devCmdPath -PathType Container) {
            $devCmdExists = $true
        }
    }
    else {
        $devCmdPath = $null
    }

    return [PSCustomObject]@{
        Path         = $path
        DevCmdPath   = $devCmdPath
        DevCmdExists = $devCmdExists
        Product      = "Visual Studio"
        Label        = "Visual Studio ${Release}"
    }
}

function Get-Visual-Studio-Build-Tools {
    param (
        [string] $Release
    )

    $releaseRange = Get-Release-Range -Release $Release

    if ($Release -eq "2015") {
        $path = . $VSWhere -legacy `
                           -version $releaseRange `
                           -property installationPath
    }
    else {
        $path = . $VSWhere -version $ReleaseRange `
                           -products "Microsoft.VisualStudio.Product.BuildTools" `
                           -property installationPath
    }

    $devCmdExists = $false

    if ($path) {
        $devCmdPath = "${path}\Common7\Tools"

        if (Test-Path -Path $devCmdPath -PathType Container) {
            $devCmdExists = $true
        }
    }
    else {
        $devCmdPath = $null
    }

    return [PSCustomObject]@{
        Path         = $path
        DevCmdPath   = $devCmdPath
        DevCmdExists = $devCmdExists
        Product      = "Visual Studio Build Tools"
        Label        = "Visual Studio Build Tools ${Release}"
    }
}



function Get-User-Path {
    return [System.Environment]::GetEnvironmentVariable(
        "PATH",
        [System.EnvironmentVariableTarget]::User
    )
}

function Get-Machine-Path {
    return [System.Environment]::GetEnvironmentVariable(
        "PATH",
        [System.EnvironmentVariableTarget]::Machine
    )
}

function Get-Path {
    param (
        [string] $Environment
    )

    switch ($Environment) {
        "User"    { return Get-User-Path    }
        "Machine" { return Get-Machine-Path }
    }
}



function Set-User-Path {
    param (
        [string] $Path
    )

    [System.Environment]::SetEnvironmentVariable(
        "PATH",
        $Path,
        [System.EnvironmentVariableTarget]::User
    )
}

function Set-Machine-Path {
    param (
        [string] $Path
    )

    [System.Environment]::SetEnvironmentVariable(
        "PATH",
        $Path,
        [System.EnvironmentVariableTarget]::Machine
    )
}

function Set-Path {
    param (
        [string] $Environment,
        [string] $Path
    )

    switch ($Environment) {
        "User"    { Set-User-Path    -Path $Path }
        "Machine" { Set-Machine-Path -Path $Path }
    }
}



function Invoke-Status {
    param (
        [object] $Path,
        [object] $Target,
        [object] $Environment
    )

    if ($Target.Path) {
        Write-Output-Info -Message "$($Target.Label): INSTALLED!"
    }
    else {
        Write-Output-Warn -Message "$($Target.Label): NOT INSTALLED!"
    }

    if ($Target.DevCmdPath -and $Path -like "*$($Target.DevCmdPath)*") {
        Write-Output-Info -Message "$($Target.Label): IN $($Environment.ToUpper()) PATH!"
    }
    else {
        Write-Output-Warn -Message "$($Target.Label): NOT IN $($Environment.ToUpper()) PATH!"
    }
}

function Invoke-Add {
    param (
        [object] $Path,
        [object] $Target,
        [object] $Environment
    )

    if ($Target.Path) {
        Write-Output-Info -Message "$($Target.Label): INSTALLED!"
    }
    else {
        Write-Output-Warn -Message "$($Target.Label): NOT INSTALLED!"
    }

    if (-not $Target.DevCmdPath) {
        Write-Output-Warn -Message "$($Target.Label): SKIPPED!"

        return
    }

    if ($Target.DevCmdPath -and $Path -like "*$($Target.DevCmdPath)*") {
        Write-Output-Info -Message "$($Target.Label): ALREADY ADDED TO $($Environment.ToUpper())!"
    }
    else {
        $path = "${path};$($Target.DevCmdPath)"

        Set-Path -Environment $Environment -Path $path

        Write-Output-Info -Message "$($Target.Label): ADDED TO $($Environment.ToUpper())!"
    }
}

function Invoke-Remove {
    param (
        [object] $Path,
        [object] $Target
    )

    if ($Target.Path) {
        Write-Output-Info -Message "$($Target.Label): INSTALLED!"
    }
    else {
        Write-Output-Warn -Message "$($Target.Label): NOT INSTALLED!"
    }

    if (-not $Target.DevCmdPath) {
        Write-Output-Warn -Message "$($Target.Label): SKIPPED!"

        return
    }

    if ($Target.DevCmdPath -and $path -like "*$($Target.DevCmdPath)*") {
        $path = ($path.Split(";") | Where-Object {
            $PSItem -ne $Target.DevCmdPath
        }) -join ";"

        Set-Path -Environment $Environment -Path $path

        Write-Output-Info -Message "$($Target.Label): REMOVED FROM $($Environment.ToUpper())!"
    }
    else {
        Write-Output-Info -Message "$($Target.Label): ALREADY REMOVED FROM $($Environment.ToUpper())!"
    }
}



function Invoke-Version {
    Write-Host -Message "3.0.0"
}

function Invoke-Help {
    Write-Host -Message ".\VsDevCmd-to-Path.ps1 -Command <Command> -Environment <Environment> -Release <Release>"
}

function Invoke-About {
    Write-Host -Message "VsDevCmd to Path"
}



try {
    if (-not $IsWindows) {
        Write-Output-Fail -Message "Windows is required!"

        throw
    }

    if ($Version) {
        Invoke-Version

        return
    }

    if ($Help) {
        Invoke-Help

        return
    }

    if ($About) {
        Invoke-About

        return
    }

    if (-not $Command -or -not $Environment -or -not $Release) {
        throw
    }

    $vsWhere = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

    if (Test-Path -Path $vsWhere -PathType Leaf) {
        Write-Output-Info -Message "vswhere.exe: FOUND!"
    }
    else {
        Write-Output-Fail -Message "vswhere.exe: NOT FOUND!"

        throw
    }

    $vs   = Get-Visual-Studio             -Release $Release
    $vsBt = Get-Visual-Studio-Build-Tools -Release $Release

    $path = Get-Path -Environment $Environment

    if ($Command -ne "Status") {
        if (-not $NoDump) {
            $pathFile = "path_$(Get-Date -Format "yyyyMMdd_HHmmss").txt"

            $path | Out-File -FilePath $pathFile -Encoding utf8
        }
    }

    switch ($Command) {
        "Status" {
            Invoke-Status -Path $path `
                            -Target $vs `
                            -Environment $Environment

            Invoke-Status -Path $path `
                            -Target $vsBt `
                            -Environment $Environment
        }

        "Add" {
            Invoke-Add -Path $path `
                       -Target $vs `
                       -Environment $Environment

            Invoke-Add -Path $path `
                       -Target $vsBt `
                       -Environment $Environment
        }

        "Remove" {
            Invoke-Remove -Path $path `
                          -Target $vs `
                          -Environment $Environment

            Invoke-Remove -Path $path `
                          -Target $vsBt `
                          -Environment $Environment
        }
    }
}
catch {
    Write-Output-Fail -Message $PSItem.Exception.Message

    exit 1
}
finally {
    exit 0
}
