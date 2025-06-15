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
    Write-Host "11. Windows Defender"
    Write-Host "--------------------------------"
    Write-Host "1. Obtener informacion del estado del antivirus"
    Write-Host "2. Realizar un escaner rapido"
    Write-Host "3. Realizar un escaner completo"
    Write-Host "4. Realizar un escaner a una carpeta"
    Write-Host "5. Parar proteccion en tiempo real (Requiere privilegios)"
    Write-Host "6. Activar proteccion en tiempo real (Requiere privilegios)"
    Write-Host "0. Volver al Inicio"

    $choice9=Read-Host "Introduce la accion a realizar (0-6)"

    switch ($choice9){
        1 {

            #Get-MpComputerStatus nos muestra por pantalla el estado de los modulos del antivirus, cuales estan activados, cuales desactivados...

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Obtener informacion del estado del antivirus"
            Write-Host "--------------------------------"
            Get-MpComputerStatus
        }
        2 {

            #Start-MpScan -ScanType QuickScan escanea el equipo de forma rapida

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Realizar un escaner rapido"
            Write-Host "--------------------------------"
            Start-MpScan -ScanType QuickScan
        }
        3 {

            #Start-MpScan -ScanType FullScan escanea el equipo de forma completa

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Realizar un escaner completo"
            Write-Host "--------------------------------"
            Start-MpScan -ScanType FullScan
        }
        4 {

            #Start-MpScan -ScanPath "$carpeta" escanea la carpeta que se le haya pasado por la variable $carpeta

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4. Realizar un escaner a una carpeta"
            Write-Host "--------------------------------"
            $carpeta=Read-Host "Introduce la ruta absoluta"
            Start-MpScan -ScanPath "$carpeta"
        }
        5 {

            #Set-MpPreference -DisableRealtimeMonitoring $true para parar la proteccion en tiempo real del antivirus 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5. Parar proteccion en tiempo real (Requiere privilegios)"
            Write-Host "--------------------------------"
            Set-MpPreference -DisableRealtimeMonitoring $true
        }
        6 {

            #Set-MpPreference -DisableRealtimeMonitoring $false para activar la proteccion en tiempo real del antivirus 

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6. Activar proteccion en tiempo real (Requiere privilegios)"
            Write-Host "--------------------------------"
            Set-MpPreference -DisableRealtimeMonitoring $false
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
