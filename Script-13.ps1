Set-ExecutionPolicy Unrestricted

Function PPause ($Message = "Presiona una tecla para continuar . . . ") 
{
    If ($psISE) 
    {
        $Shell = New-Object -ComObject "WScript.Shell"
        $Button = $Shell.Popup($Message, 0, "Script Paused", 0)
        Return
    }
    Write-Host -NoNewline $Message
    $Ignore =
    16, # Shift (left or right)
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
    183 # Application 2
    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) 
    {
        $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    Write-Host
}

do 
{

    #Estas son unas cuantas herramientas la mayoria graficas para poder comprobar la integridad de archivos, seguridad de la red y seguridad del equipo
    #No requieren de instalacion para ejecutarlas ya que estan instaladas en los archivos del script aunque algunas si requieren de privilegios del sistema

    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "13. Herramientas de auditoria"
    Write-Host "--------------------------------"

    Write-Host "1. Hash My Files"
    Write-Host "2. Usuarios conectados al sistema"
    Write-Host "3. WifiInfoView"
    Write-Host "4. Bluetoothview"
    Write-Host "5. Escaneo con nmap"
    Write-Host "6. Escaneo con nmap a un equipo"
    Write-Host "7. Registry Explorer"
    Write-Host "8. L0phtCrack"
    Write-Host "9. USBdeview"
    Write-Host "10. TCPView"
    Write-Host "0. Volver al Inicio"

    $choice9=Read-Host "Introduce la accion a realizar (0-10)"

    switch ($choice9){
        1 {

            #./ruta al archivo.exe para llamar a ese archivo y ejecutarlo /file $file para pasarle el archivo a hashear

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Hash My Files"
            Write-Host "--------------------------------"
            $file = Read-Host "Introduce el nombre del archivo (Con su ruta absoluta/relativa)"
            .\PROGRAMAS\HASHMYFILES\HashMyFiles.exe /file "$file"
        }
        2 {
            
            #netplwiz es una utilidad de microsoft incorporada en el sistema para ver si hay algun usario conectado 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Usuarios conectados al sistema"
            Write-Host "--------------------------------"
            Start-Process "netplwiz"
        }
        3 {

            #WiFiInfowView para ver las redes wifis disponibles 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. WifiInfoView"
            Write-Host "--------------------------------"
            .\PROGRAMAS\WIFIINFOVIEW\WifiInfoView.exe
        }
        4 {

            #Bluetoothview para ver los dispositivos bluetooth que estan en la zona

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Bluetoothview"
            Write-Host "--------------------------------"
            .\PROGRAMAS\bluetoothview\BluetoothView.exe
        }
        5 {

            #nmap es una herramienta que desde terminal de comandos es muy potente y sirve para escanear equipos que esten conectados a la misma red que tu
            #Requiere nmap instalado se instala desde el apartado de instaladores.
            #nmap -sS -p- "ip de la red" para escanear toda la red en busca de todos equipos y que puertos estan en escucha

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Escaneo con nmap a la red"
            Write-Host "--------------------------------"
            $net=Read-Host "Introduce en la red que te encuentras en formato aaa.bbb.ccc.ddd/ee" 
            nmap -sS -p- $net
        }
        6 {

            #nmap -sS -p- "ip de un equipo" para escanear todo ese equipo 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6. Escaneo con nmap a un equipo"
            Write-Host "--------------------------------"
            $ip=Read-Host "Introduce la IP del equipo a escanear"
            nmap -sS -p- $ip
        }
        7 {

            #Abre la herramienta de Registry Explorer util para obtener informacion de archivos que normalmente estan bloqueados por windows como por ejemplo el archivo SAM 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "7. Registry Explorer"
            Write-Host "--------------------------------"
            .\PROGRAMAS\RegistryExplorer\RegistryExplorer.exe
        }
        8 {

            #Abre l0phtCrack que es una utilidad que en Windows te puede llegar a ser util para hacer un ataque a las contraseñas que usa el sistema para comprobar su seguridad

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "8. L0phtCrack"
            Write-Host "--------------------------------"
            .\PROGRAMAS\L0phtCrack\lc7.exe


           
        }
        9 {

            #USBdeview para ver los dispositivos que estan o han sido conectados por USB a la maquina

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "9. USBdeview"
            Write-Host "--------------------------------"
            .\PROGRAMAS\usbdeview\USBDeview.exe
        }
        10 {

            #Una herramienta grafica para ver que conexiones tiene el equipo activas

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "10. TCPView"
            Write-Host "--------------------------------"
            .\PROGRAMAS\Tcpview\Tcpview.exe
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
