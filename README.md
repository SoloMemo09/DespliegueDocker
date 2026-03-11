#Como correr el docker-compose en la maquina MAC 

 Chin Cervera Carlos Guillermo, Nuñez Che Rafael Abisai, Lozano Contreras Luis Enrique
**Práctica:** Despliegue de un Sistema LMS Moodle con GitHub/Docker en una Mac Pro 2019

Crea un archivo nuevo, pega este código y guárdalo exactamente con el nombre docker-compose.yml. Este archivo es el que se encarga de crear y levantar el Moodle y su base de datos.

![Uploading image.png…]()

'''
version: '3.8'

services:
  mariadb:
    image: bitnami/mariadb:latest
    environment:
      - MARIADB_USER=bn_moodle
      - MARIADB_DATABASE=bitnami_moodle
      - ALLOW_EMPTY_PASSWORD=yes
    volumes:
      - 'mariadb_data:/bitnami/mariadb'

  moodle:
    image: bitnami/moodle:latest
    ports:
      - '8080:8080'
    environment:
      - MOODLE_DATABASE_HOST=mariadb
      - MOODLE_DATABASE_PORT_NUMBER=3306
      - MOODLE_DATABASE_USER=bn_moodle
      - MOODLE_DATABASE_NAME=bitnami_moodle
      - ALLOW_EMPTY_PASSWORD=yes
    depends_on:
      - mariadb
    volumes:
      - 'moodle_data:/bitnami/moodle'

volumes:
  mariadb_data:
  moodle_data:


'''


 1. Para ejecutar este contenedor en la Mac Pro del laboratorio, sigue estos comandos en la terminal:

  git clone [https://github.com/Solomemo09/DespliegueDocker.git](https://github.com/Solomemo09/DespliegueDocker.git)
   cd DespliegueDocker

2. Levantar el Moodle con Docker Compose:

   docker-compose up -d

3. Acceder a la plataforma:
   Abre el navegador web e ingresa a http://localhost:8080

4. Instrucciones básicas para crear un curso en Moodle
Una vez que el sistema esté corriendo y hayas iniciado sesión con las credenciales de administrador, sigue estos pasos:

Ve al menú lateral y selecciona "Administración del sitio".

Haz clic en la pestaña "Cursos" y luego en "Administrar cursos y categorías".

Presiona el botón que dice "Crear nuevo curso".

Llena los campos obligatorios:

Nombre completo del curso (ej. "Introducción a la Ciberseguridad").

Nombre corto del curso.

Desplázate hasta el final de la página y haz clic en "Guardar cambios y mostrar".


  
