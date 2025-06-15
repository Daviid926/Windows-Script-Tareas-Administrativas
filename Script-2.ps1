Set-ExecutionPolicy Unrestricted  # Permitir ejecución de scripts

# ------------ FUNCTION PPAUSE ----------------------------------------------------------------
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
        183  # Application 2

    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) 
    {
        $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    Write-Host
}

    # Limpia la pantalla y muestra el menú de información de Software
    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "2. Informacion del Software"
    Write-Host "--------------------------------"
    # Comando para obtener información del Sistema Operativo
    Get-ComputerInfo | Select-Object Windows*

    # Pausa para que el usuario vea los resultados
    PPause ("Presiona una tecla para volver al menu..")
