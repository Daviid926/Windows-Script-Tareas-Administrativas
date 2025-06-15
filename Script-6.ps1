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
    Write-Host "6. Procesos"
    Write-Host "--------------------------------"
    Write-Host "1. Ver procesos activos"
    Write-Host "2. Obtener un proceso por su PID"
    Write-Host "3. Obtener proceso por su Nombre"
    Write-Host "4. Matar un proceso por su PID"
    Write-Host "5. Matar un proceso por su Nombre"
    Write-Host "6. Matar forzadamente un proceso por su PID"
    Write-Host "7. Matar forzadamente un proceso por su Nombre"
    Write-Host "0. Volver al Inicio"
    $choice8 = Read-Host "Introduce la accion a realizar (0-7)"

    switch ($choice8) {
        1 {

            #Get-Process para obtener los procesos activos y con | out-host para que se puedan leer por pantalla

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Ver procesos activos"
            Write-Host "--------------------------------"
            Clear-Host
            Get-Process | Out-Host
        }
        2 {
            
            #Con get-Process -id $pid1 le obtenemos la informacion de un proceso por su PID

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Obtener un proceso por su PID"
            Write-Host "--------------------------------"
            Clear-Host
            $pid1 = Read-Host "Introduce numero del PID"
            Get-Process -Id $pid1
        }
        3 {

            #Con get-Process -name *$proname* le obtenemos la informacion de un proceso por su nombre
            #Los asteriscos son para no tener que poner el nombre completo del proceso

            Write-Host "--------------------------------"
            Write-Host "3. Obtener proceso por su Nombre"
            Write-Host "--------------------------------"
            Clear-Host
            $proname = Read-Host "Introduce nombre del proceso"
            Get-Process -Name *$proname* | Out-Host
        }
        4 {

            #Stop-Process -Id $killpid1 a partir del PID que pasamos por la variable killpid1 mata a ese proceso sin forzar

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Matar un proceso por su PID"
            Write-Host "--------------------------------"
            Clear-Host
            $killpid1 = Read-Host "Introduce numero del PID"
            Stop-Process -Id $killpid1
        }
        5 {

            #Stop-Process -Name $killname a partir del nombre que pasamos por la variable killname mata a ese proceso sin forzar 
            #Los asteriscos son para no tener que poner el nombre completo del proceso

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Matar un proceso por su Nombre"
            Write-Host "--------------------------------"
            Clear-Host
            $killname = Read-Host "Introduce nombre del proceso"
            Stop-Process -Name *$killname*
        }
        6 {

            #Stop-Process -Id $killpid1 a partir del PID que pasamos por la variable killpid1 mata a ese proceso de forma forzada

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6. Matar forzadamente un proceso por su PID"
            Write-Host "--------------------------------"
            Clear-Host
            $killpid1 = Read-Host "Introduce numero del PID"
            Stop-Process -Id $killpid1 -Force
        }
        7 {

            #Stop-Process -Name $killname a partir del nombre que pasamos por la variable killname mata a ese proceso de forma forzada 
            #Los asteriscos son para no tener que poner el nombre completo del proceso

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "7. Matar forzadamente un proceso por su Nombre"
            Write-Host "--------------------------------"
            Clear-Host
            $killname = Read-Host "Introduce nombre del proceso"
            Stop-Process -Name *$killname* -Force
        }
        0 {
            exit
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-7"
        }
    }

    PPause ("Presiona una tecla para volver al menu..")
} while ($choice -ne 0)
