Set-ExecutionPolicy Unrestricted

Function PPause ($Message = "Presiona una tecla para continuar . . . ") {
    If ($psISE) {
        $Shell = New-Object -ComObject "WScript.Shell"
        $Button = $Shell.Popup($Message, 0, "Script Paused", 0)
        Return
    }
    Write-Host -NoNewline $Message
    $Ignore = 
        16,  # Shift (left or right)
        17,  # Ctrl (left or right)
        18,  # Alt (left or right)
        20,  # Caps lock
        91,  # Windows key (left)
        92,  # Windows key (right)
        93,  # Menu key
        144, # Num lock
        145, # Scroll lock
        166, # Back
        167, # Forward
        168, # Refresh
        169, # Stop
        170, # Search
        171, # Favorites
        172, # Start/Home
        173, # Mute
        174, # Volume Down
        175, # Volume Up
        176, # Next Track
        177, # Previous Track
        178, # Stop Media
        179, # Play
        180, # Mail
        181, # Select Media
        182, # Application 1
        183  # Application 2
    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) {
        $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    Write-Host
}

do {
    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "5. Almacenamiento"
    Write-Host "--------------------------------"

    # Selecciona la informacion a obtener 
    Write-Host "1. Obtener informacion del disco logico"
    Write-Host "2. Obtener informacion del disco fisico"
    Write-Host "3. Obtener informacion sobre las particiones"
    Write-Host "4. Obtener informacion de los volumenes"
    Write-Host "5. CrystalDiskInfo"
    Write-Host "0. Volver al Inicio"

    $choice7 = Read-Host "Introduce la accion a realizar (0-5)"

    switch ($choice7) {
        1 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Obtener informacion del disco logico"
            Write-Host "--------------------------------"
            Get-Disk
        }
        2 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Obtener informacion del disco fisico"
            Write-Host "--------------------------------"
            Get-PhysicalDisk
        }
        3 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Obtener informacion sobre las particiones"
            Write-Host "--------------------------------"
            Get-Partition
        }
        4 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Obtener informacion de los volumenes"
            Write-Host "--------------------------------"
            Get-Volume
        }
        5 {

            #Con esta opcion se hace una llamada al programa crystaldisk para que se ejecute y poder ver la informacion del estado del disco

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. CrystalDiskInfo"
            Write-Host "--------------------------------"
            Start-Process .\PROGRAMAS\CRYSTALDISK\DiskInfo64.exe
        }
        0 {
            exit
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-5"
        }
    }

    PPause ("Presiona una tecla para volver al menu..")
} while ($choice -ne 0)
