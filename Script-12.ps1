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
    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "12. Windows Update (Se requieren privilegios elevados)"
    Write-Host "--------------------------------"

    Write-Host "1. Instalar modulo de actualizacion desde powershell"
    Write-Host "2. Obtener actualizaciones"
    Write-Host "3. Actualizar el equipo"
    Write-Host "4. Parar servico de Windows Update"
    Write-Host "5. Deshabilitar para que no se active "
    Write-Host "6. Habilitar y arrancar el servicio "
    Write-Host "0. Volver al Inicio"

    $choice9=Read-Host "Introduce la accion a realizar (0-6)"

    switch ($choice9){
        1 {
            
            #Hay que instalar el modulo de actualizacion para powershell para poder gestionar el tema de las actualizacion

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Instalar modulo de actualizacion desde powershell"
            Write-Host "--------------------------------"
            Install-Module -Name PSWindowsUpdate -Force
        }
        2 {

            #Una vez instalado ya se pueden usar los siguientes comandos.
            #Get-Windows update para obtener la actualizacion

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Obtener actualizaciones"
            Write-Host "--------------------------------"
            Get-WindowsUpdate
        }
        3 {

            #Install-WindowsUpdate para ejecutar la acutalizacion del equipo

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Actualizar el equipo"
            Write-Host "--------------------------------"
            Install-WindowsUpdate
        }
        4 {

            #Stop-Service -Name wuauserv -force para parar momentaneamente las actualizaciones

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Parar servico de Windows Update"
            Write-Host "--------------------------------"
            Stop-Service -Name wuauserv -Force
        }
        5 {

            #Set-Service -Name wuauserv -StartupType Disabled para deshabilitar que se arranque el servicio de las actualizaciones 
            #Sin este servicio activo Windows no se va a seguir actualizando

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Deshabilitar para que no se active"
            Write-Host "--------------------------------"
            Set-Service -Name wuauserv -StartupType Disabled
        }
        6 {

            #Set-Service -Name wuauserv -StartupType Automatic para que el servicio se arranque cada vez que se inicia windowss
            #Start-Service -Name wuauserv para arrancar el servicio

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6. Habilitar y arrancar el servicio"
            Write-Host "--------------------------------"
            Set-Service -Name wuauserv -StartupType Automatic; Start-Service -Name wuauserv
        }
        0 {
            exit
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-6"
        }
    }

    PPause ("Presiona una tecla para volver al menu..") 
} while ($choice9 -ne 0)
