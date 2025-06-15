Set-ExecutionPolicy Unrestricted

Function PPause ($Message = "Presiona una tecla para continuar . . . ") {
    If ($psISE) {
        $Shell = New-Object -ComObject "WScript.Shell"
        $Button = $Shell.Popup($Message, 0, "Script Paused", 0)
        Return
    }
    Write-Host -NoNewline $Message
    $Ignore = 16, # Shift (left or right)
              17, # Ctrl (left or right)
              18, # Alt (left or right)
              20, # Caps lock
              91, # Windows key (left)
              92, # Windows key (right)
              93, # Menu key
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

    #En este apartado he puesto las configuraciones que me parecen basicas a la hora de configurar por primera vez un equipo

    Write-Host "--------------------------------"
    Write-Host "10. Configuracion Basica"
    Write-Host "--------------------------------"
    Write-Host "1. Cambiar idioma del teclado"
    Write-Host "2. Cambiar fecha y hora"
    Write-Host "3. Establecer fecha y hora automatica"
    Write-Host "4. Cambiar nombre del equipo"
    Write-Host "5. Cambiar grupo de trabajo"
    Write-Host "0. Volver al Inicio"

    $choice9 = Read-Host "Introduce la accion a realizar (0-5)"

    switch ($choice9) {
        1 { 
            
            #Set-WinUserLanguageList $lang -force para indicar el idioma que queremos asignar al teclado

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Cambiar idioma del teclado"
            Write-Host "--------------------------------"
            Clear-Host
            $lang = Read-Host "Introduce el idioma a establecer en formato aa-aa"
            Set-WinUserLanguageList "$lang" -Force
        }
        2 { 

            #Set-Date -Date $fecha $hora para a traves de las variables $fecha y $hora establecer la nueva fecha

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Cambiar fecha y hora"
            Write-Host "--------------------------------"
            Clear-Host
            $fecha = Read-Host "Introduce la fecha a establecer en formato aa/aa/aaaa"
            $hora = Read-Host "Introduce la hora a establecer en formato aa:aa"
            Set-Date -Date "$fecha $hora"
        }
        3 { 

            #w32tm /resync resincroniza la informacion del reloj con la de microsoft

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Establecer fecha y hora automatica"
            Write-Host "--------------------------------"
            Clear-Host
            w32tm /resync
        }
        4 { 

            #Rename-computer -NewName $nombre -force para establecer un nuevo nombre de equipo
            #Se debe reiniciar el equipo despues usar esta opcion

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Cambiar nombre del equipo"
            Write-Host "--------------------------------"
            Clear-Host
            $nombre = Read-Host "Introduce el nuevo nombre del equipo"
            Rename-Computer -NewName "$nombre" -Force

            
        }
        5 { 
             
             # Add-Computer -WorkGroupName "$workgroup" -Force para establecer un grupo de trabajo   
             #Se debe reiniciar el equipo despues usar esta opcion

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Cambiar grupo de trabajo"
            Write-Host "--------------------------------"
            Clear-Host
            $workgroup = Read-Host "Introduce el nuevo grupo de trabajo del equipo"
            Add-Computer -WorkGroupName "$workgroup" -Force
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
} while ($choice9 -ne 0)
