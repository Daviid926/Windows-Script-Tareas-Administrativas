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
        183  # Application 2

    While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) 
    {
        $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    }
    Write-Host
}
do {
    # ----------- Pregunta que tipo de usuarios y los guarda en la variable choice ------------
    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "Que tipo de usuarios"
    Write-Host "--------------------------------"
    Write-Host "1. Usuarios Locales"
    Write-Host "2. Usuarios del Dominio"
    Write-Host "0. Salir"

    $choice2 = Read-Host "Introduce una opcion (0-2)"

    # ----------- Dependiendo de cual sea el tipo de usuarios se usan comandos para administrar usuarios del dominio o locales ------------
    switch($choice2) {
        1 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Gestion de usuarios locales"
            Write-Host "--------------------------------"
            Write-Host "1. Obtener lista de usuarios"
            Write-Host "2. Crear usuario"
            Write-Host "3. Borrar usuario"
            Write-Host "4. Activar usuario"
            Write-Host "5. Desactivar usuario"
            Write-Host "6. Obtener informacion de un usuario"
            Write-Host "0. Salir"

            $choice3 = Read-Host "Introduce una opcion (0-6)"

            switch ($choice3) { 
            # Ejecuta la opción seleccionada se usan comandos para interactuar con usuarios locales de la maquina
                1 {
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "1. Obtener lista de usuarios"
                    Write-Host "--------------------------------"
                    Get-LocalUser
                }
                2 {
                    # Crea un usuario -Name para darle nombre Password para asignarle contraseña se usa ConvertTo-SecureString porque si no el comando falla
                    # -Fullname para asignarle el nombre completo y -Description para la descripcion del usuario
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "2. Crear usuario"
                    Write-Host "Nota: Tienes que usar una contraseña segura"
                    Write-Host "--------------------------------"
                    $name = Read-Host "Introduce nombre usuario"
                    $passwd = Read-Host "Introduce contraseña"
                    $Fname = Read-Host "Introduce el nombre"
                    $Desc = Read-Host "Descripcion"
                    New-LocalUser -Name $name -Password (ConvertTo-SecureString $passwd -AsPlainText -Force) -FullName $Fname -Description $Desc
                }
                3 {

                    #Se pide al usuario que introduzca el nombre de usuario a borrar y lo borra
                
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "3. Borrar usuario"
                    Write-Host "--------------------------------"
                    $duser = Read-Host "Nombre del usuario a borrar"
                    Remove-LocalUser -Name $duser
                }
                4 {

                    #Se pide al usuario que introduzca el nombre de usuario a activar y lo activar
                        
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "4. Activar usuario"
                    Write-Host "--------------------------------"
                    $euser = Read-Host "Nombre del usuario a activar"
                    Enable-LocalUser -Name $euser
                }
                5 {

                    #Se pide al usuario que introduzca el nombre de usuario a deshabilitar y lo deshabilitar

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "5. Deshabilitar usuario"
                    Write-Host "--------------------------------"
                    $duser = Read-Host "Nombre del usuario a deshabilitar"
                    Disable-LocalUser -Name $duser
                }
                6 {
                    
                   #Se pide al usuario que introduzca el nombre de usuario a deshabilitar y lo deshabilita 

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "6. Obtener informacion de un usuario"
                    Write-Host "--------------------------------"
                    $getuser = Read-Host "Nombre de usuario" 
                    Get-LocalUser -Name $getuser 
                }
                0 { exit }
                default {

                     Clear-Host
                     Write-Host "Opción incorrecta"
                         }
            }
        }
        2 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "3. Gestionar usuarios del dominio"
            Write-Host "--------------------------------"
            Write-Host "1. Obtener lista de usuarios"
            Write-Host "2. Crear usuario"
            Write-Host "3. Borrar usuario"
            Write-Host "4. Activar usuario"
            Write-Host "5. Desactivar usuario"
            Write-Host "6. Obtener informacion de un usuario"
            Write-Host "0. Salir"

            $choice4 = Read-Host "Introduce una opcion (0-6)"

            switch ($choice4) { 
            # Ejecuta la opción seleccionada, se usan comandos relacionados con el directorio activo para gestionar a los usuarios que estan dentro del dominio
                1 {
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "1. Obtener lista de usuarios"
                    Write-Host "--------------------------------"
                    Get-ADUser -Filter *
                }
                2 {

                    # Crea un usuario CN=$dname junto con -samid $dname como argumento para darle nombre y despues con CN= Users se introduce en el grupo de los Users
                    # Y DC es para indicarle en que dominio esta, hay dos porque tiene que ser introducido de la siguiente forma si forma parte del dominio prueba.local
                    # Se le debera de introducir como primera parte del dominio prueba y como segunda local.
                    # -pwd para asignarle la contraseña

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "2. Crear usuario"
                    Write-Host "Nota: Tienes que usar una contraseña segura"
                    Write-Host "--------------------------------"
                    $dname = Read-Host "Introduce nombre usuario"
                    $dpasswd = Read-Host "Introduce contraseña"
                    $domain1 = Read-Host "Introduce la primera parte del dominio"
                    $domain2 = Read-Host "Introduce la segunda parte del dominio"
                    dsadd user "CN=$dname,CN=Users,DC=$domain1,DC=$domain2" -samid $dname -pwd $dpasswd
                }
                3 {

                    #Remove-ADUser para eliminar un usuario que se le pasa con el -Identity que esta siendo recogido por la variable dduser1
                    #-Confirm:$false para que no pida confirmacion a la hora de eliminarlo

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "3. Borrar usuario"
                    Write-Host "--------------------------------"
                    $dduser1 = Read-Host "Nombre del usuario a borrar"
                    Remove-ADUser -Identity $dduser1 -Confirm:$false
                }
                4 {

                    #Enable-ADAccount con -Identity $dduser2 para activar el usuario que le hayamos pasado a esa variable
                    
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "4. Habilitar usuario"
                    Write-Host "--------------------------------"
                    $dduser2 = Read-Host "Nombre del usuario a habilitar"
                    Enable-ADAccount -Identity $dduser2
                }
                5 {

                    #Disable-ADAccount con -Identity $dduser3 para deshabilitar el usuario que le hayamos pasado a esa variable

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "5. Deshabilitar usuario"
                    Write-Host "--------------------------------"
                    $dduser3 = Read-Host "Nombre del usuario a deshabilitar"
                    Disable-ADAccount -Identity $dduser3
                }
                6 {

                    #Get-ADUser para obtener la informacion de un usuario -Filter para a partir de SamAccountName -eq $adgetuser podamos seleccionar el usuario deseado
                    #Y por ultimo -Properties * para obtener toda la informacion

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "6. Obtener informacion de un usuario"
                    Write-Host "--------------------------------"
                    $adgetuser = Read-Host "Nombre de usuario" 
                    Get-ADUser -Filter "SamAccountName -eq '$adgetuser'" -Properties *
                }

                0 { exit }
                default {

                     Clear-Host
                     Write-Host "Opción incorrecta"

                         }
            }
        }
        # ----------- Regresa al menu  ------------
        0 { exit }
        default {
            Clear-Host
            Write-Host "Opción incorrecta: Selecciona una del 0-2"
        }
    }

    PPause ("Presiona una tecla para volver al menú..")
} while ($choice -ne 0)
