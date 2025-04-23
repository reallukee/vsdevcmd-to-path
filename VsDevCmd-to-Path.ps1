#
# ****************
# VsDevCmd to Path
# ****************
#
# Aggiungi o rimuovi VsDevCmd dalla variabile %PATH%
#
# https://github.com/reallukee/vsdevcmd-to-path
#
# Author  : Luca Pollicino
#           (https://github.com/reallukee)
# Version : 2.0.0
# License : MIT
#

param ($Operation, $Environment, $Version)

function Log-Info {
    param ([string]$Message)

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host "`e[32m[INFO] $Message`e[0m"
    } else {
        Write-Host "[INFO] $Message"
    }
}

function Log-Warning {
    param ([string]$Message)

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host "`e[33m[WARNING] $Message`e[0m"
    } else {
        Write-Host "[WARNING] $Message"
    }
}

function Log-Error {
    param ([string]$Message)

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host "`e[31m[ERROR] $Message`e[0m"
    } else {
        Write-Host "[ERROR] $Message"
    }
}



# Write-Host $Operation
# Write-Host $Environment
# Write-Host $Version

if (-not $Operation -or -not $Environment -or -not $Version) {
    Write-Host ""
    Write-Host "****************"
    Write-Host "VsDevCmd to Path"
    Write-Host "     v2.0.0     "
    Write-Host "****************"
    Write-Host ""
    Write-Host "https://github.com/reallukee/vsdevcmd-to-path"
    Write-Host ""
    Write-Host "Usage: .\VsDevCmd-to-Path.ps1 <Operation> <Environment> <Version>"
    Write-Host ""
    Write-Host "-Operation   : [Status|Add|Remove]"
    Write-Host "-Environment : [User|Machine]"
    Write-Host "-Version     : [2017|2019|2022]"
    Write-Host ""

    exit 0
} else {
    $Operations = @("Status", "Add", "Remove")
    $ValidOperation = $Operations -contains $Operation

    if (-not $ValidOperation) {
        Log-Error "Invalid operation!"
        Log-Error "$Operation is an invalid operation!"
        Log-Error "Type: .\VsDevCmd-to-Path.ps1"

        Write-Host ""

        Write-Host "Operation failed!"

        exit 1
    }

    $Environments = @("User", "Machine")
    $ValidEnvironment = $Environments -contains $Environment

    if (-not $ValidEnvironment) {
        Log-Error "Invalid environment!"
        Log-Error "$Environment is an invalid environment!"
        Log-Error "Type: .\VsDevCmd-to-Path.ps1"

        Write-Host ""

        Write-Host "Operation failed!"

        exit 1
    }

    $Versions = @("2017", "2019", "2022")
    $ValidVersion = $Versions -contains $Version

    if (-not $ValidVersion) {
        Log-Error "Invalid version!"
        Log-Error "$Version is an invalid version!"
        Log-Error "Type: .\VsDevCmd-to-Path.ps1"

        Write-Host ""

        Write-Host "Operation failed!"

        exit 1
    }
}



Write-Host ""
Write-Host "****************"
Write-Host "VsDevCmd to Path"
Write-Host "     v2.0.0     "
Write-Host "****************"
Write-Host ""
Write-Host "https://github.com/reallukee/vsdevcmd-to-path"
Write-Host ""
Write-Host "Operation   : $Operation"
Write-Host "Environment : $Environment"
Write-Host "Version     : $Version"
Write-Host ""



$VSWhere = "$Env:ProgramFiles (x86)\Microsoft Visual Studio\Installer\vswhere.exe"

if (Test-Path $VSWhere) {
    Log-Info "VSWhere.exe found!"
} else {
    Log-Error "VSWhere.exe not found!"

    Write-Host ""

    Write-Host "Operation failed!"

    exit 1
}



switch ($Version) {
    "2022" {
        $Version = "[17.0,18.0)";
        break
    }

    "2019" {
        $Version = "[16.0,17.0)";
        break
    }

    "2017" {
        $Version = "[15.0,16.0)";
        break
    }
}



$VsPath = & $VSWhere -version $Version -requires "Microsoft.Component.MSBuild" -property installationPath
$VsBtPath = & $VSWhere -version $Version -products "Microsoft.VisualStudio.Product.BuildTools" -property installationPath
$VsDevCmdPath = "$VsPath\Common7\Tools"
$VsBtDevCmdPath = "$VsBtPath\Common7\Tools"
$VsDevCmdPathFind = $false
$VsBtDevCmdPathFind = $false

if (Test-Path "$VsDevCmdPath\VsDevCmd.bat") {
    Log-Info "Visual Studio VsDevCmd.bat found!"

    $VsDevCmdPathFind = $true;
} else {
    Log-Warning "Visual Studio VsDevCmd.bat not found!"

    $VsDevCmdPath = $null;
}

if (Test-Path "$VsBtDevCmdPath\VsDevCmd.bat") {
    Log-Info "Visual Studio Build Tools VsDevCmd.bat found!"

    $VsBtDevCmdPathFind = $true;
} else {
    $VsBtDevCmdPath = $null;

    Log-Warning "Visual Studio Build Tools VsDevCmd.bat not found!"
}

# Write-Host $VsPath
# Write-Host $VsBtPath
# Write-Host $VsDevCmdPath
# Write-Host $VsBtDevCmdPath
# Write-Host $VsDevCmdPathFind
# Write-Host $VsBtDevCmdPathFind



if ($Environment -eq "User") {
    $Path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
}

if ($Environment -eq "Machine") {
    $Path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
}



if ($Operation -ne "Status") {
    $now = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")

    $Path | Out-File -FilePath "$($Environment.ToUpper())_DUMP_$now.txt"
}



$NewPath = $Path

if ($Operation -eq "Status") {
    if ($VsDevCmdPathFind) {
        Log-Info "Visual Studio                          : Installed!"
    } else {
        Log-Info "Visual Studio                          : NOT installed!"
    }

    if ($Path -like "*$VsDevCmdPath*" -and $VsDevCmdPath -ne $null) {
        Log-Info "Visual Studio VsDevCmd.bat             : Added to %PATH%!"
    } else {
        Log-Info "Visual Studio VsDevCmd.bat             : NOT added to %PATH%!"
    }



    if ($VsBtDevCmdPathFind) {
        Log-Info "Visual Studio Build Tools              : Installed!"
    } else {
        Log-Info "Visual Studio Build Tools              : NOT installed!"
    }

    if ($Path -like "*$VsBtDevCmdPath*" -and $VsBtDevCmdPath -ne $null) {
        Log-Info "Visual Studio Build Tools VsDevCmd.bat : Added to %PATH%!"
    } else {
        Log-Info "Visual Studio Build Tools VsDevCmd.bat : NOT added to %PATH%!"
    }
}



if ($Operation -eq "Add") {
    Log-Info "Adding Visual Studio VsDevCmd.bat to $Environment %PATH%..."

    if ($Path -notlike "*$VsDevCmdPath*" -and $VsDevCmdPathFind) {
        $NewPath = "$NewPath;$VsDevCmdPath"
    } else {
        Log-Warning "Visual Studio VsDevCmd.bat already added!"
    }

    Log-Info "Visual Studio VsDevCmd.bat successfully added!"



    Log-Info "Adding Visual Studio Build Tools VsDevCmd.bat to $Environment %PATH%..."

    if ($Path -notlike "*$VsBtDevCmdPath*" -and $VsBtDevCmdPathFind) {
        $NewPath = "$NewPath;$VsBtDevCmdPath"
    } else {
        Log-Warning "Visual Studio Build Tools VsDevCmd.bat already added!"
    }

    Log-Info "Visual Studio Build Tools VsDevCmd.bat successfully added!"
}



if ($Operation -eq "Remove") {
    Log-Info "Removing Visual Studio VsDevCmd.bat from $Environment %PATH%..."

    if ($Path -like "*$VsDevCmdPath*" -and $VsDevCmdPathFind) {
        $NewPath = ($NewPath.Split(";") | Where-Object { $_ -ne $VsDevCmdPath }) -join ";"
    } else {
        Log-Warning "Visual Studio VsDevCmd.bat already removed!"
    }

    Log-Info "Visual Studio VsDevCmd.bat successfully removed!"



    Log-Info "Removing Visual Studio Build Tools VsDevCmd.bat from $Environment %PATH%..."

    if ($Path -like "*$VsBtDevCmdPath*" -and $VsBtDevCmdPathFind) {
        $NewPath = ($NewPath.Split(";") | Where-Object { $_ -ne $VsBtDevCmdPath }) -join ";"
    } else {
        Log-Warning "Visual Studio Build Tools VsDevCmd.bat already removed!"
    }

    Log-Info "Visual Studio Build Tools VsDevCmd.bat successfully removed!"
}



if ($Environment -eq "User") {
    [System.Environment]::SetEnvironmentVariable("PATH", $NewPath, [System.EnvironmentVariableTarget]::User)
}

if ($Environment -eq "Machine") {
    [System.Environment]::SetEnvironmentVariable("PATH", $NewPath, [System.EnvironmentVariableTarget]::Machine)
}



Write-Host ""

Write-Host "Operation completed!"

exit 0
