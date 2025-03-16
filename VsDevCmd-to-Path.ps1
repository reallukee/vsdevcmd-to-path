#
# ++++++++++++++++
# VsDevCmd to Path
# ++++++++++++++++
#
# Aggiunge (o rimuove) VsDevCmd alla variabile Path
#
# https://github.com/reallukee/vsdevcmd-to-path
#
# Author      : Luca Pollicino
#               (https://github.com/reallukee)
# Version     : 1.0.0
# License     : MIT
#

param ($operation, $environment)

function Log-Info {
    param ([string]$message)

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host "[INFO] `e[32m$message`e[0m"
    } else {
        Write-Host "[INFO] $message"
    }
}

function Log-Warning {
    param ([string]$message)

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host "[WARNING] `e[33m$message`e[0m"
    } else {
        Write-Host "[WARNING] $message"
    }
}

function Log-Error {
    param ([string]$message)

    If ($PSVersionTable.PSVersion -gt [version]"6.0.0.0") {
        Write-Host "[ERROR] `e[31m$message`e[0m"
    } else {
        Write-Host "[ERROR] $message"
    }
}



# Write-Host $operation
# Write-Host $environment

if (-not $operation -or -not $environment) {
    # Write-Host "++++++++++++++++"
    # Write-Host "VsDevCmd to Path"
    # Write-Host "     v1.0.0     "
    # Write-Host "++++++++++++++++"

    Write-Host "++++++++++++++++"
    Write-Host "VsDevCmd to Path"
    Write-Host "++++++++++++++++"
    Write-Host ""
    Write-Host "Aggiunge (o rimuove) VsDevCmd alla variabile Path"
    Write-Host ""
    Write-Host "Version : 1.0.0"
    Write-Host "Author  : Luca Pollicino (https://github.com/reallukee)"
    Write-Host ""

    Write-Host ".\VsDevCmd-to-Path.ps1 <Operation> <Environment>"

    Write-Host ""

    Write-Host "-operation: [Add|Remove]"
    Write-Host "-environment: [User|Machine]"

    exit 0
} else {
    $validOperation = $false;
    $operations = @("Add", "Remove")

    for ($i = 0; $i -lt $operations.Length; $i++) {
        if ($operation -eq $operations[$i]) {
            $validOperation = $true
        }
    }

    if (-not $validOperation) {
        Log-Error "Invalid Operation!"
        Log-Error '"$operation" is an invalid Operation!'
        Log-Error 'Type ".\VsDevCmd-to-Path.ps1"'

        exit 1
    }

    $validEnvironment = $false;
    $environments = @("User", "Machine")

    for ($i = 0; $i -lt $environments.Length; $i++) {
        if ($environment -eq $environments[$i]) {
            $validEnvironment = $true
        }
    }

    if (-not $validEnvironment) {
        Log-Error "Invalid Operation!"
        Log-Error '"$operation" is an invalid Operation!'
        Log-Error 'Type ".\VsDevCmd-to-Path.ps1"'

        exit 1
    }
}

# Write-Host "++++++++++++++++"
# Write-Host "VsDevCmd to Path"
# Write-Host "     v1.0.0     "
# Write-Host "++++++++++++++++"

Write-Host "++++++++++++++++"
Write-Host "VsDevCmd to Path"
Write-Host "++++++++++++++++"
Write-Host ""
Write-Host "Aggiunge (o rimuove) VsDevCmd alla variabile Path"
Write-Host ""
Write-Host "Version : 1.0.0"
Write-Host "Author  : Luca Pollicino (https://github.com/reallukee)"
Write-Host ""

Write-Host "Operation   : $operation"
Write-Host "Environment : $environment"

Write-Host ""

$VSWhere = "$env:ProgramFiles (x86)\Microsoft Visual Studio\Installer\vswhere.exe"

if (Test-Path $VSWhere) {
    Log-Info "VSWhere.exe found!"
} else {
    Log-Error "VSWhere.exe not found!"

    exit 1
}

$VsPath = & $VSWhere -prerelease -latest -property installationPath
$VsDevCmdPath = "$VsPath\Common7\Tools"

# Write-Host $VsPath
# Write-Host $VsDevCmdPath

if (Test-Path "$VsDevCmdPath\VsDevCmd.bat") {
    Log-Info "VsDevCmd.bat found!"
} else {
    Log-Error "VsDevCmd.bat not found!"

    exit 1
}

if ($environment -eq "User") {
    $path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
}

if ($environment -eq "Machine") {
    $path = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
}

# Write-Host $path

$now = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")

$path | Out-File -FilePath "$($environment.ToUpper())_DUMP_$now.txt"

if ($path -notlike "*$VsDevCmdPath") {
    if ($operation -eq "Add") {
        $newPath = "$path;$VsDevCmdPath"

        # Write-Host $newPath

        Log-Info "Adding to $environment PATH..."

        if ($environment -eq "User") {
            [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::User)
        }

        if ($environment -eq "Machine") {
            [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::Machine)
        }
    }
}

if ($path -like "*$VsDevCmdPath") {
    if ($operation -eq "Remove") {
        $newPath = ($path.Split(";") | Where-Object { $_ -ne $VsDevCmdPath }) -join ";"

        # Write-Host $newPath

        Log-Info "Removing from $environment PATH..."

        if ($environment -eq "User") {
            [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::User)
        }

        if ($environment -eq "Machine") {
            [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::Machine)
        }
    }
}

# Write-Host $path

if ($operation -eq "Add") {
    Log-Info "VsDevCmd.bat added to PATH!"
    Log-Info "Adding Completed!"
}

if ($operation -eq "Remove") {
    Log-Info "VsDevCmd.bat removed from PATH!"
    Log-Info "Removing Completed!"
}

Write-Host ""

Write-Host "Operation Completed!"

exit 0
