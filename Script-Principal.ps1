# -------------------------------------
# Powershell script
# -------------------------------------
# Autor: David Lorente Rubira
# Fecha: 1--2025
# Version: 1.0
# -------------------------------------
# Script creado por David Lorente Rubira.
# -------------------------------------
# Licencia : CC BY-NC-SA (Creative Commons Attribution-NonCommercial-ShareAlike)
# -------------------------------------
# Este es un script enfocado a realizar tareas administrativas
# Usando comandos compatibles con Powershell.
# -------------------------------------
# -------------------------------------
# En este script algunas opciones requieren de la instalación de programas.
# -------------------------------------
# Todos los programas necesarios pueden ser instalados desde la carpeta Programas/Instaladores
# O bien pueden ser instalados via este script en el apartado 14 Instaladores.
# -------------------------------------
# También hay programas que no requieren de instalación para ser ejecutados.
# -------------------------------------
# Si en tu equipo no es posible ejecutar scripts probablemente esten desactivados
# Para comprobar eso hay que abrir un Powershell como administrador y ejecutar el siguiente comando Get-ExecutionPolicy
# Una vez ejecutado si sale Restricted no podrás ejecutar ningún script en tu maquina
# Con el siguiente comando puedes permitir la ejecución de scripts en tu maquina
# Set-ExecutionPolicy Unrestricted
# -------------------------------------


Set-ExecutionPolicy Unrestricted  # Permite al usuario ejecutar scripts sin restricciones

# ------------ Funcion de PPause ----------------------------------------------------------------
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

    # Espera hasta que el usuario presione una tecla válida
    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) 
    {
        $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    Write-Host
}



# ----------- Comprobar parametro -h o --help ------------
if ($args -contains "-h" -or $args -contains "--help") {
    Write-Host ""
    Write-Host ""
    Write-Host "Script creado por David Lorente Rubira"
    Write-Host ""
    Write-Host "Este es un script enfocado a realizar tareas administrativas"
    Write-Host "Usando comandos compatibles con powershell."
    Write-Host ""
    Write-Host ""
    Write-Host "En este script algunas opciones requieren de la instalacion de programas"
    Write-Host "Todos los programas necesarios pueden ser instalados desde la carpeta Programas/Instaladores"
    Write-Host "O bien pueden ser instalados via este script en el apartado 14 Instaladores"
    Write-Host "También hay programas que no requieren de instalacion para ser ejecutados"
    Write-Host ""
    Write-Host ""
    exit
}

# ----------- Comprobar parametro -v o --version ------------
if ($args -contains "-v" -or $args -contains "--version") {
    Write-Host ""
    Write-Host ""
    Write-Host "Script creado por David Lorente Rubira"
    Write-Host ""
    Write-Host "Version : 0.9"
    Write-Host ""
    Write-Host "License : CC BY-NC-SA (Creative Commons Attribution-NonCommercial-ShareAlike)"
    Write-Host "Licencia : CC BY-NC-SA (Creative Commons Atribucion-No Comercial-Compartir Igual)"
    Write-Host ""
    exit
}



# ----------- Bucle principal ------------
do 
{
    Clear-Host

    # Mostrar información básica del sistema
    Write-Host "Informacion Basica:"
    Write-Host "------------------"
    Write-Host "Nombre Usuario:" $env:USERNAME
    Write-Host "Nombre PC:" $env:COMPUTERNAME
    Write-Host ""
    Write-Host "Fecha: " -NoNewline
    Get-Date -DisplayHint Date
    Write-Host "Hora: " -NoNewline
    Get-Date -DisplayHint Time
    Write-Host "Direcciones IP" -NoNewline
    Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress

    # Mostrar menú principal
    Write-Host "----------------------------------------------------------------------------"
    Write-Host "Bienvenido al Script para gestionar el Sistema Operativo"
    Write-Host "----------------------------------------------------------------------------"
    Write-Host "1. Informacion de Hardware"
    Write-Host "2. Informacion de Software"
    Write-Host "3. Gestionar Usuarios"
    Write-Host "4. Gestionar Grupos"
    Write-Host "5. Almacenamiento"
    Write-Host "6. Procesos"
    Write-Host "7. Servicios"
    Write-Host "8. Red"
    Write-Host "9. Herramientas administrativas"
    Write-Host "10. Configuracion Basica"
    Write-Host "11. Windows Defender (Se requieren privilegios elevados)"
    Write-Host "12. Windows Update (Se requieren privilegios elevados)"
    Write-Host "13. Herramientas de auditoria"
    Write-Host "14. Instaladores"
    Write-Host "15. Atajos"
    Write-Host ""
    Write-Host "0. Salir"
    Write-Host "----------------------------------------------------------------------------"
    Write-Host "Seleccione una opcion:"

    # Leer opción del usuario
    $choice = Read-Host "Introduce la accion a realizar (0-15)"

    # Ejecuta la opción seleccionada
    # Con & ".\nombre-script" llamo a otro Script contenido en la misma carpeta
    switch ($choice)
    {
        1  { & ".\Script-1.ps1" }
        2  { & ".\Script-2.ps1" }
        3  { & ".\Script-3.ps1" }
        4  { & ".\Script-4.ps1" }
        5  { & ".\Script-5.ps1" }
        6  { & ".\Script-6.ps1" }
        7  { & ".\Script-7.ps1" }
        8  { & ".\Script-8.ps1" }
        9  { & ".\Script-9.ps1" }
        10 { & ".\Script-10.ps1" }
        11 { & ".\Script-11.ps1" }
        12 { & ".\Script-12.ps1" }
        13 { & ".\Script-13.ps1" }
        14 { & ".\Script-14.ps1" }
        15 { & ".\Script-15.ps1" }
        0  {
            # Mensaje final al salir
            Clear-Host
            Write-Host ""
            Write-Host ""
            Write-Host "Gracias por usar mi script..."
            Write-Host "" 
            PPause ("Presiona una tecla para salir..")
            exit}



        # Si no se elige una opción válida
        default 
        {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-15"
            PPause ("Presiona una tecla para volver al menu..")
        }
    }

} while ($choice -ne 0)


