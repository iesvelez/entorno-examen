# entorno-examen
Playbook de Ansible acompañado de ciertos scripts para la generación automática de entornos de examen en OpenStack


## Instrucciones

1. Editar `deploy.conf` y especificar los datos de configuración.
2. Cargar el archivo de credenciales de OpenStack con `source proyecto-openrc.sh`
3. Crear las instancias y asociarles una IP flotante a cada una con `./deploy.sh`. La lista de instancias y su IP quedará escrita en el archivo `deployed.txt`.
4. Crear una contraseña de root para cada instancia con `./gen-passwords.sh`. La lista de contraseñas quedará escrita en el archivo `passwords.txt`.
5. Modificar el Playbook de Ansible para indicar la configuración deseada.
6. Ejecutar el script `./provision.sh` para aplicar el Playbook a todas las instancias. Se creará automáticamente el archivo de inventario `hosts` con los datos adecuados de conexión.


## Controlando las instancias

El script `action.sh` permite realizar las siguientes operaciones sobre las instancias:

* `start`/`stop`: Iniciar/detener todas las instancias.
* `suspend`/`resume`: Suspender/reanudar todas las instancias.
* `pause`/`unpause`: Pausar/reaunudar todas las instancias.
* `lock`/`unlock`: Bloquear/desbloquear para evitar cambios accidentales.


## Terminando el escenario

Para destruir todas las instancias se puede utilizar el script `terminate.sh`.

