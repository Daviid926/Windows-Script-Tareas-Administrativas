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

    #Instaladores de programas que mas utiles resultan y que estoy utilizando mucho a la hora de instalar software en equipos,
    #Tambien hay instaladores como .NET y Nmap que son para cosas unicamente relacionadas con el script

    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "14. Instaladores"
    Write-Host "--------------------------------"
    Write-Host "1. Chrome+Firefox+LibreOffice+7zip+Thunderbird+VLC"
    Write-Host "2. Chrome+Firefox+7zip+Thunderbird+VLC"
    Write-Host "3. Chrome+7zip"
    Write-Host "4. 7zip"
    Write-Host "5. Chrome+Firefox"
    Write-Host "6. Chrome"
    Write-Host "7. Firefox"
    Write-Host "8. VLC"
    Write-Host "9. Thunderbird"
    Write-Host "10. Nmap"
    Write-Host "11. .NET"
    Write-Host "0. Volver al Inicio"

    $choice9=Read-Host "Introduce la accion a realizar (0-11)"

    switch ($choice9){
        1 {

            #./ruta al archivo.exe para llamar a ese archivo y ejecutarlo para instalar el programa

            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1.Chrome+Firefox+LibreOffice+7zip+Thunderbird+VLC"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"7Zip Chrome Firefox LibreOffice Thunderbird.exe"
        }
        2 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2.Chrome+Firefox+7zip+Thunderbird+VLC"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"7Zip Chrome Firefox Thunderbird VLC.exe"
        }
        3 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3.Chrome+7zip"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"7Zip Chrome.exe"
        }
        4 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "4.7zip"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"7Zip.exe"
        }
        5 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "5.Chrome+Firefox"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"Chrome Firefox.exe"
        }
        6 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "6.Chrome"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"Chrome.exe"
        }
        7 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "7.Firefox"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"Firefox.exe"
        }
        8 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "8.VLC"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"Thunderbird VLC.exe"
        }
        9 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "9.Thunderbird"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"Thunderbird.exe"
        }
        10 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "10.Nmap"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"nmap.exe"
        }
        11 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "11. .NET"
            Write-Host "--------------------------------"
            .\PROGRAMAS\INSTALADORES\"dotnet.exe"
        }

        0 {
            exit
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-11"
        }
    }

    PPause ("Presiona una tecla para volver al menu..") 
} while ($choice9 -ne 0)