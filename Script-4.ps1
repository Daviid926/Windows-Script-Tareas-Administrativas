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
    # ----------- Pregunta que tipo de usuarios y los guarda en la variable choice ------------
    Clear-Host
    Write-Host "--------------------------------"
    Write-Host "Que tipo de grupos"
    Write-Host "--------------------------------"
    Write-Host "1. Grupos locales"
    Write-Host "2. Grupos del dominio"
    Write-Host "0. Volver al inicio"
    Write-Host "Nota: Para modificar los grupos del dominio es mejor desde la herramienta grafica"

    $choice5 = Read-Host "Selecciona una opcion (0-2)"

    # ----------- Dependiendo de cual sea el tipo de usuarios se usan comandos para administrar usuarios del dominio o locales ------------

    switch ($choice5) {
        1 {
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "1. Gestionar grupos locales"
            Write-Host "--------------------------------"
            # 

            Write-Host "1. Crear grupo"
            Write-Host "2. Borrar grupo"
            Write-Host "3. Anadir un usuario a un grupo"
            Write-Host "4. Quitar un usuario de un grupo"
            Write-Host "5. Listar grupos"
            Write-Host "6. Obtener informacion sobre un grupo"
            Write-Host "0. Volver al inicio"
            $choice6 = Read-Host "Selecciona una opcion (0-6)"
            
            switch ($choice6) {
            #Se usan comandos encargados de gestionar los grupos locales
                1 {

                    #New-LocalGroup -name y le pasamos la variable $group1 para el nombre del grupo y -description para la descripcion pasada desde $groupdesc

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "1. Crear grupo"
                    Write-Host "--------------------------------"
                    $group1 = Read-Host "Nombre del grupo"
                    $groupdesc = Read-Host "Descripcion del grupo"
                    New-LocalGroup -Name "$group1" -Description "$groupdesc"
                }
                2 {

                    #Remove-LocalGroup -name y le pasamos la variable $grouprem1 para el nombre del grupo a eliminar

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "2. Borrar grupo"
                    Write-Host "--------------------------------"
                    $grouprem1 = Read-Host "Nombre del grupo"
                    Remove-LocalGroup -Name "$grouprem1"
                }
                3 {

                    #Add-LocalGroupMember -Group $groupadd1 para seleccionar el grupo al que nos referimos y -member $useradd1 para pasarle el usuario que queremos añadir

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "3. Anadir un usuario a un grupo"
                    Write-Host "--------------------------------"
                    $groupadd1 = Read-Host "Nombre del grupo"
                    $useradd1 = Read-Host "Nombre del usuario"
                    Add-LocalGroupMember -Group "$groupadd1" -Member "$useradd1"
                }
                4 {

                    #Remove-LocalGroupMember -Group $groupdel1 para seleccionar el grupo al que nos referimos y -member $userdel1 para pasarle el usuario que queremos añadir

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "4. Quitar un usuario de un grupo"
                    Write-Host "--------------------------------"
                    $groupdel1 = Read-Host "Nombre del grupo"
                    $userdel1 = Read-Host "Nombre del usuario"
                    Remove-LocalGroupMember -Group "$groupdel1" -Member "$userdel1"
                }
                5 {

                    #get-localgroup con el asterisco para poder listar todos los grupos locales

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "5. Listar grupos"
                    Write-Host "--------------------------------"
                    get-localgroup *
                }
                6 {

                    #get-localgroup con $getgroup que es el nombre del grupo que queremos obtener la informacion

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "6. Obtener informacion sobre un grupo"
                    Write-Host "--------------------------------"
                    $getgroup = Read-Host "Nombre del grupo"
                    get-localgroup $getgroup
                }
                0 {
                    exit
                }
            }
        }
        2 {
            #Se usan comandos encargados de gestionar los grupos del dominio
            Clear-Host
            Write-Host "--------------------------------"
            Write-Host "2. Gestionar grupos del dominio"
            Write-Host "--------------------------------"
            Write-Host "1. Crear grupo del dominio"
            Write-Host "2. Borrar grupo del dominio"
            Write-Host "3. Anadir un usuario a un grupo del dominio"
            Write-Host "4. Quitar un usuario de un grupo del dominio"
            Write-Host "5. Listar grupos del dominio"
            Write-Host "6. Obtener informacion sobre un grupo del dominio"
            Write-Host "0. Volver al inicio"
            $choice6 = Read-Host "Selecciona una opcion (0-6)"
            
            switch ($choice6) {
                1 {

                    #New-ADGroup para crear un nuevo grupo del dominio con este script solo se pueden crear grupos globales
                    # -Name $adgroup1 para pasarle el nombre del grupo -Description $adgroupdesc para la descripcion
                    #-GroupScope global para configurar el grupo como grupo global

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "1. Crear grupo del dominio"
                    Write-Host "--------------------------------"
                    $adgroup1 = Read-Host "Nombre del grupo"
                    $adgroupdesc = Read-Host "Descripcion del grupo"
                    New-ADGroup -Name "$adgroup1" -Description "$adgroupdesc" -GroupScope Global
                }
                2 {

                    #Remove-ADGroup -Identity $adgrouprem1 que con ese parametro le pasamos el nombre del grupo a eliminar

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "2. Borrar grupo del dominio"
                    Write-Host "--------------------------------"
                    $adgrouprem1 = Read-Host "Nombre del grupo"
                    Remove-ADGroup -Identity "$adgrouprem1"
                }
                3 {

                    #Add-ADGroupMember -Indentity para seleccionar el grupo y con -members $aduseradd1 le pasamos el usuario que queremos anadir

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "3. Anadir un usuario a un grupo del dominio"
                    Write-Host "--------------------------------"
                    $adgroupadd1 = Read-Host "Nombre del grupo"
                    $aduseradd1 = Read-Host "Nombre de usuario"
                    Add-ADGroupMember -Identity "$adgroupadd1" -Members "$aduseradd1"
                }
                4 {

                    #Remove-ADGroupMember para quitar un usuario de un grupo 
                    #-Indentity para seleccionar el grupo y con -members $aduserdel1 le pasamos el usuario que queremos quitar

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "4. Quitar un usuario de un grupo del dominio"
                    Write-Host "--------------------------------"
                    $adgroupdel1 = Read-Host "Nombre del grupo"
                    $aduserdel1 = Read-Host "Nombre de usuario"
                    Remove-ADGroupMember -Identity "$adgroupdel1" -Members "$aduserdel1"
                }
                5 {

                    #get-ADgroup para obtener la lista de los grupos que hay en el dominio con -filter * para seleccionar todos los grupos
                    
                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "5. Listar grupos del dominio"
                    Write-Host "--------------------------------"
                    get-ADgroup -filter *
                }
                6 {

                    #get-adgroup con el nombre de un grupo para obtener la informacion de ese grupo

                    Clear-Host
                    Write-Host "--------------------------------"
                    Write-Host "6. Obtener informacion sobre un grupo del dominio"
                    Write-Host "--------------------------------"
                    $adgetgroup = Read-Host "Nombre del grupo"
                    get-ADgroup $adgetgroup
                }
            }
        }
        0 {
            exit
        }
        default {
            Clear-Host
            Write-Host "Opcion incorrecta: Selecciona una del 0-2"
        }
    }

    PPause ("Presiona una tecla para volver al menu..")
} while ($choice -ne 0)
