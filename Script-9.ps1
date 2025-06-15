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
    
    #Son las herramientas graficas que usa windows para realizar tareas administrativas, solo estan las que considero mas utiles

    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "9. Herramientas administrativas"
    Write-Host "--------------------------------"
    Write-Host "1. Panel de control"
    Write-Host "2. Gestion de usuarios y grupos locales"
    Write-Host "3. Gestion de usuarios y equipos dominio"
    Write-Host "4. Administrador de discos"
    Write-Host "5. Visor de eventos"
    Write-Host "6. Servicios"
    Write-Host "7. Configuracion del sistema"
    Write-Host "8. Informacion del sistema"
    Write-Host "9. Firewall"
    Write-Host "10. Administrador del sistema"
    Write-Host "0. Volver al Inicio"

    $choice9 = Read-Host "Introduce la accion a realizar (0-10)"

    switch ($choice9) {

        #Clear-host para limpiar la pantalla y el ; para poder realizar otro comando en la misma linea para que quede mas comprimido
        #Start-Process "nombre del proceso" para poder ejecutarlo

        1  { Clear-Host; Start-Process "control" }
        2  { Clear-Host; Start-Process "lusrmgr.msc" }
        3  { Clear-Host; Start-Process "dsa.msc" }
        4  { Clear-Host; Start-Process "diskmgmt.msc" }
        5  { Clear-Host; Start-Process "eventvwr.msc" }
        6  { Clear-Host; Start-Process "services.msc" }
        7  { Clear-Host; Start-Process "msconfig.exe" }
        8  { Clear-Host; Start-Process "msinfo32.exe" }
        9  { Clear-Host; Start-Process "WF.msc" }
        10 { Clear-Host; Start-Process "compmgmt.msc" }
        0  { exit }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-10"
        }
    }

    PPause ("Presiona una tecla para volver al menu..")
} while ($choice9 -ne 0)
