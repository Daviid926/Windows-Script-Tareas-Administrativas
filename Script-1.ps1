Set-ExecutionPolicy Unrestricted  # Permitir ejecución de scripts

# ------------ FUNCTION PPAUSE ----------------------------------------------------------------
Function PPause ($Message = "Presiona una tecla para continuar . . . ") 
{
    # Si el script se ejecuta en PowerShell ISE, muestra una ventana emergente
    If ($psISE) 
    {
        $Shell = New-Object -ComObject "WScript.Shell"
        $Button = $Shell.Popup($Message, 0, "Script Paused", 0)
        Return
    }

    # Si no, muestra un mensaje y espera una tecla válida
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
        183  # Application 2

    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) 
    {
        $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    Write-Host
}

# ----------- Bucle principal ------------
do 
{
    Clear-Host

    # Menú principal de información de Hardware
    Write-Host "--------------------------------"
    Write-Host "1. Informacion de Hardware"
    Write-Host "--------------------------------"

    Write-Host "1. Obtener informacion de CPU"
    Write-Host "2. Obtener informacion de RAM"
    Write-Host "3. Obtener informacion de GPU"
    Write-Host "0. Volver al Inicio"

    # Solicitar al usuario la opción deseada
    $choice1 = Read-Host "Introduce la accion a realizar (0-3)"

    # Ejecuta la opción seleccionada
    switch ($choice1)
    {
        # ----------- Obtiene informacion del CPU a traves del comando Get-CimInstance ------------
        1 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Obtener informacion de CPU"
            Write-Host "--------------------------------"
            Get-CimInstance Win32_Processor  # Mostrar información de CPU
        }
        # ----------- Obtiene informacion de la RAM a traves del comando Get-CimInstance ------------
        2 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Obtener informacion de RAM"
            Write-Host "--------------------------------"
            Get-CimInstance Win32_PhysicalMemory  # Mostrar información de RAM
        }
        # ----------- Obtiene informacion de la GPU a traves del comando Get-CimInstance ------------
        3 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Obtener informacion de GPU"
            Write-Host "--------------------------------"
            Get-CimInstance Win32_VideoController  # Mostrar información de GPU
        }
        # ----------- Regresa al menu  ------------
        0 {
            exit  
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-3"
        }
    }

    # Pausa para que el usuario vea los resultados
    PPause ("Presiona una tecla para volver al menu..")	

} while ($choice1 -ne 0)
