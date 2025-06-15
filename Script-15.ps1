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

    #En este apartado estan los comandos que mas estoy utilizando ultimamente en las practicas
    
    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "15. Atajos"
    Write-Host "--------------------------------"
    Write-Host "1. Reiniciar servicio de cola de impresion"
    Write-Host "2. Detectar equipos en red (arp -a)"
    Write-Host "3. Escanear equipo y reparar fallos"
    Write-Host "4. Parar firewall de Windows"
    Write-Host "5. Activar firewall de Windows"
    Write-Host "6. Borrar archivos temporales"
    Write-Host "0. Volver al Inicio"

    $choice9 = Read-Host "Introduce la accion a realizar (0-6)"

    switch ($choice9) {
        1 { 

            #Net stop spooler para parar la cola de impresion y net start spooler para volver a activarla,
            #Muy util para cuando se queda un fichero en la cola de impresion y no se llega a imprimir y tampoco lo puedes cancelar

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Reiniciar servicio de cola de impresion"
            Write-Host "--------------------------------"
            Clear-Host
            net stop spooler
            net start spooler
            
        }
        2 { 

            #Buena utilidad de microsoft para cuando en una red pequena te hace falta identificar la ip de una impresora sin tener acceso a ella
            #Impresora o cualquier otro tipo de dispositivo que se conecte a la red

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Detectar equipos en red (arp -a)"
            Write-Host "--------------------------------"
            Clear-Host
            arp -a 
        }
        3 { 

            #sfc /scannow muy util cuando el equipo hace cosas de software que se notan raras para intentar repararlas desde el cmd

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Escanear equipo y reparar fallos"
            Write-Host "--------------------------------"
            Clear-Host
            sfc /scannow
        }
        4 { 
            
            #Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False ,
            #util para hacer comprobaciones para ver si un dispositivo no conecta con otro por culpa del firewall

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Parar firewall de Windows"
            Write-Host "--------------------------------"
            Clear-Host
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
            
        }
        5 {
        
            #Una vez hechas esas comprobaciones Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
            #Para volver a activar el firewall para evitar fallos de seguridad
         
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Activar firewall de Windows"
            Write-Host "--------------------------------"
            Clear-Host
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
            
        }
        6 {
            #Los archivos temporales son archivos que son generados por programas que deberian ser borrados una vez cerrado el programa
            #Muchas veces estos archivos no se borran y hay que borrarlos manualmente
            #Si da error es porque hay archivos que no se pueden borrar porque estan siendo usados
            #Solo se borra si la instalacion de Windows esta en la Unidad C:
         
            Clear-Host
            rm -Force -Recurse -Confirm:$false C:\Windows\Temp\*
            rm -Force -Recurse -Confirm:$false C:\Users\$env:USERNAME\AppData\Local\Temp\*
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6. Borrar archivos temporales"
            Write-Host "--------------------------------"
            Write-Host "Archivos borrados correctamente."
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
