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
    Write-Host "7. Servicios"
    Write-Host "--------------------------------"
    Write-Host "1. Obtener informacion de los servicios"
    Write-Host "2. Iniciar un servicio parado"
    Write-Host "3. Parar un servicio"
    Write-Host "4. Reiniciar un servicio"
    Write-Host "5. Obtener informacion de un servicio"
    Write-Host "0. Volver al Inicio"

    $choice9 = Read-Host "Introduce la accion a realizar (0-5)"

    switch ($choice9) {
        1 {
            
            #  Obtiene informacion de los servicios activos 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Obtener informacion de los servicios"
            Write-Host "--------------------------------"
            Get-Service
        }
        2 {

            # Start-Service -Name "$proccessname" este comando arranca el servicio que le pasemos a traves de la variable processname

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Iniciar un servicio parado"
            Write-Host "--------------------------------"
            $processname = Read-Host "Introduce nombre del servicio"
            Start-Service -Name "$processname"
        }
        3 {

            #Stop-Service -Name "$stopproccessname" este comando para el servicio que le pasemos a traves de la variable stopprocessname
            
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Parar un servicio"
            Write-Host "--------------------------------"
            $stopprocessname = Read-Host "Introduce nombre del servicio"
            Stop-Service -Name "$stopprocessname"
        }
        4 {

            #Restart-Service -Name "$reprocessname" este comando reinicia el servicio que le pasemos a traves de la variable reprocessname

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Reiniciar un servicio"
            Write-Host "--------------------------------"
            $reprocessname = Read-Host "Introduce nombre del servicio"
            Restart-Service -Name "$reprocessname"
        }
        5 {

            #Get-Service "$sname" este comando indica el estado del servicio que hayamos pasado con la variable get-service

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Obtener informacion de un servicio"
            Write-Host "--------------------------------"
            $sname = Read-Host "Introduce nombre del servicio"
            Get-Service $sname
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
