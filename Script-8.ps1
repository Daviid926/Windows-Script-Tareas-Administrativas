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
    Write-Host "8. Red"
    Write-Host "--------------------------------"
    Write-Host "1. Hacer ping a una IP"
    Write-Host "2. Hacer un tracert a una IP"
    Write-Host "3. Obtener direccion mac del equipo"
    Write-Host "4. Obtener informacion de la configuracion de red"
    Write-Host "5. Obtener conexiones todas las conexiones y puertos en escucha"
    Write-Host "6. Limpiar cache del dns"
    Write-Host "7. Liberar configuracion tarjeta de red (Se requieren privilegios)"
    Write-Host "8. Obtener nueva configuracion de red (DHCP) (Se requieren privilegios)"
    Write-Host "9. Obtener nombre del adaptador de red"
    Write-Host "10. Actualizar configuracion de red (Se requieren privilegios)"
    Write-Host "0. Volver al Inicio"

    $choice9 = Read-Host "Introduce la accion a realizar (0-10)"

    switch ($choice9) {
        1 {

            #ping $pingip para hacer un ping a la ip que le pasemos a traves de la variable $pingip

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Hacer ping a una IP"
            Write-Host "--------------------------------"
            $pingip = Read-Host "Introduce la ip a hacer un ping"
            ping $pingip
            Write-Host ""
        }
        2 {

            #tracert $tip para hacer un tracert a la ip que le pasemos a traves de la variable $tip y ver la ruta que hace hasta esa ip

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Hacer un tracert a una IP"
            Write-Host "--------------------------------"
            $tip = Read-Host "Introduce la ip a hacer una traza"
            tracert $tip
            Write-Host ""
        }
        3 {

            #getmac para obtener la mac de nuestra interfaz de red

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Obtener direccion mac del equipo"
            Write-Host "--------------------------------"
            getmac
            Write-Host ""
        }
        4 {

            #ipconfig /all para obtener toda la informacion de las tarjetas de red que estan instaladas en nuestro equipo

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Obtener informacion de la configuracion de red"
            Write-Host "--------------------------------"
            ipconfig /all
            Write-Host ""
        }
        5 {

            #netstat -a nos enseña las conexiones que esta realizando nuestro equipo y por que puerto

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Obtener conexiones todas las conexiones y puertos en escucha"
            Write-Host "--------------------------------"
            netstat -a
            Write-Host ""
        }
        6 {

            #ipconfig /flushdns para limpiar la cache del dns.

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6. Limpiar cache del dns"
            Write-Host "--------------------------------"
            ipconfig /flushdns
            Write-Host "Cache del dns limpiada"
            Write-Host ""
        }
        7 {

            #ipconfig /release para soltar la configuracion de red de todas las tarjetas de red

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "7. Liberar configuracion tarjeta de red"
            Write-Host "--------------------------------"
            ipconfig /release
            Write-Host "Configuracion liberada"
            Write-Host ""
        }
        8 {

            #ipconfig /renew para obtener una ip nueva en las tarjetas de red, se obtendran a traves de DHCP

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "8. Obtener nueva configuracion de red (DHCP)"
            Write-Host "--------------------------------"
            ipconfig /renew
            Write-Host "Configuracion renovada"
            Write-Host ""
        }
        9 {

            #get-netadapter para obtener informacion del adaptador de red

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "9. Obtener informacion del adaptador de red"
            Write-Host "--------------------------------"
            get-netadapter
            Write-Host ""
        }
        10 {

            #Get-NetIPAddress -InterfaceAlias "$interfaz" | Remove-NetIPAddress este comando sirve para "perder" la ip que esta asignada a esta tarjeta de red
            #New-NetIPAddress -InterfaceAlias "$interfaz" -IPAddress "$newip" -PrefixLength "$prefixmasc" con este comando le decimos que a la interfaz que tengamos
            #seleccionada con $interfaz le asigne la ip $newip y con -PrefixLength le pasamos la mascara de red
            #Set-DnsClientServerAddress -InterfaceAlias $interfaz -ServerAddresses ("$dns1", "$dns2") este comando sirve para pasarle a la interfaz $interfaz
            # las variables $dns1 y $dns2 y se asignen como dns.

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "10. Establecer configuracion de red (Se requieren privilegios)"
            Write-Host "--------------------------------"
            $interfaz = Read-Host "Introduce index de la interfaz"
            $newip = Read-Host "Introduce la ip nueva"
            $prefixmasc = Read-Host "Introduce la longitud de la mascara ej. 8,16,24..."
            $dns1 = Read-Host "Introduce el primer dns"
            $dns2 = Read-Host "Introduce el segundo dns"
            Get-NetIPAddress -InterfaceAlias "$interfaz" | Remove-NetIPAddress
            New-NetIPAddress -InterfaceAlias "$interfaz" -IPAddress "$newip" -PrefixLength "$prefixmasc"
            Set-DnsClientServerAddress -InterfaceAlias $interfaz -ServerAddresses ("$dns1", "$dns2")
            Write-Host ""
        }
        0 {
            exit
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-10"
        }
    }

    PPause ("Presiona una tecla para volver al menu..")
} while ($choice9 -ne 0)
