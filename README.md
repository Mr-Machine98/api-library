# Proyecto Api API RESTful biblioteca

Hola mi nombre es Juan Camilo y a continuación presento el proyecto de una API
RESTful, utilizando Spring Boot, para gestionar una biblioteca de libros y demostrar habilidades en bases de datos SQL y PL/SQL.

las tecnologías utilizadas fueron:
- Java 17 para el backend.
- Postgresql para la BD.
- Postman para el cliente.

## Instalación & compilación del proyecto
> [!IMPORTANT] 
> 
> 1. El primer paso es tener la base de datos de Postgresql e instalarla, recordar  el usuario
> y contraseña que establecen al instalar esta BD, ya que es el que utilizaremos para configurar 
> el archivo application.properties para la conexión de la api a la bd. Pueden descargar la BD  
> en [PostgreSQL](https://www.postgresql.org/download/).
> 
> 2. Siguiente, al tener ya el gestor Postgresql, se procede a crear el schema, para este   
> proyecto lo llamé db_library_api, crear este esquema es fácil se pueden guiar de la interfaz  
> de postgresql, igualmente es darle clic derecho al icono DataBase > Create > Database...
> 
> 3. Ya teniendo esto, estará listo todo para iniciar el proyecto, el único paso es ingresar al 
> proyecto y configurar el archivo *application.properties* como se muestra en el siguiente 
> gráfico.
> 
> ### Application.properties
> ```
>   # Configuración para PostgreSQL proyecto Backend
>   spring.datasource.url=jdbc:postgresql://localhost:5432/db_library_api
>   spring.datasource.username=postgres
>   spring.datasource.password=admin
>   spring.datasource.driver-class-name=org.postgresql.Driver
>   spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
>   spring.jpa.hibernate.ddl-auto=create-drop
>   spring.application.name=api-library
>   spring.jpa.show-sql=true
>   logging.level.org.hibernate.SQL=debug
> ```
> Esto es lo que se debe configurar para ingresar a la bd, en mi caso ese es el usr y pass + el nombre de la bd db_library_api.
> ```
> *spring.datasource.url=jdbc:postgresql://localhost:5432/db_library_api*
> *spring.datasource.username=postgres*
> *spring.datasource.password=admin*
> ```
> 
> ### Ejecución 
>
> Yo utilicé ECLIPSE como IDE, ya agregado el proyecto al IDE procedemos a instalar las dependencias, 
> el administador de paquetes es Gradle, por lo que se debe buscar y darle Refresh Gradle Project.
> ### Dependencias utilizadas Gradle
> ``` Gradle
> implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
> implementation 'org.springframework.boot:spring-boot-starter-web'
> compileOnly 'org.projectlombok:lombok'
> developmentOnly 'org.springframework.boot:spring-boot-devtools'
> runtimeOnly 'org.postgresql:postgresql'
> annotationProcessor 'org.projectlombok:lombok'
>```
>
> 
> ```
> Al ejecutar el proyecto automáticamente carga unos datos de prueba en las tablas para
> realizar las consultas a los endpoints, este archivo se encuentra en
>
> */api-library/src/main/resources/import.sql* .
>```
>
>### Los Entregables Externos
> ```
> Los archivos .SQL requieridos para la prueba como: schema.sql, query.sql, stored_procedure.sql, function.sql. Se encuentran en la siguiente ruta del proyecto. Igualmente estos se puede ejecutar pegandolos en una hoja de Postgres para ser ejecutados después de haber instalado todo correctamente.
>
> /api-library/sqls
> ```

## Test Proyecto
la ruta raiz para acceder a la api es **http://localhost:8080/api/libros**, despúes de libros comenzamos a consumir los Enpoints.

## Obtener todos los libros
Utilizamos el método GET agregando depúes de libros /all, ej: **http://localhost:8080/api/libros/all**.
eso devolverá algo como:
``` JSON
[
    {
        "id": 1,
        "titulo": "El Señor de los Anillos",
        "fechaPublicacion": "1954-07-29",
        "tipo": "Fantasía",
        "autores": [
            {
                "id": 2,
                "nombre": "George Orwell",
                "email": "orwell@example.com"
            },
            {
                "id": 3,
                "nombre": "Gabriel García Márquez",
                "email": "marquez@example.com"
            }
        ]
    },
    {
        "id": 2,
        "titulo": "1984",
        "fechaPublicacion": "1949-06-08",
        "tipo": "Distopía",
        "autores": [
            {
                "id": 2,
                "nombre": "George Orwell",
                "email": "orwell@example.com"
            }
        ]
    }
    
]
```
## Agregar un nuevo libro
Utilizamos el método POST con la dirección original, ej: **http://localhost:8080/api/libros**. Y en el body mandamos el json, ej:
``` JSON
{
        "id": 12,
        "titulo": "TEST LIBRO 2",
        "fechaPublicacion": "2007-03-27",
        "tipo": "Fantasía",
        "autores" : [
            {
                "id": 10,
                "nombre": "Ken Follett",
                "email": "follett@example.com"
            }
        ]
        
}
```
Si se vuelve a enviar valida y entrega el siguiente mensaje:  *No se pudo guardar el libro, ya existe en la BD!.*


## Obtener un libro por id
Utilizamos el método GET y agregamos en la dirección original el id /{id} , ej: **http://localhost:8080/api/libros/12**. Eso devolvera el libro:
``` JSON
{
    "id": 12,
    "titulo": "Libro TEST 2",
    "fechaPublicacion": "2024-05-20",
    "tipo": "Histórica",
    "autores": []
}
```

## Eliminar un libro por id
Utilizamos el método DELETE y agregamos en la dirección original el id /{id} , ej: **http://localhost:8080/api/libros/12**. Eso devolvera el libro un status OK.

## Actualizar un  libro
Utilizamos el método PUT con la dirección original, ej: **http://localhost:8080/api/libros**. Y en el body mandamos el json, ej:
``` JSON
{
    "id": 12,
    "titulo": "TEST LIBRO PARA ACTUALIZAR",
    "fechaPublicacion": "2024-05-27",
    "tipo": "Fantasía"
    
}
```
Si todo salio bien saldrá un STATUS OK 200, igualemente valida, si no existe el libro mandará un msm diciendo "El libro no existe. Por favor crea el libro para poder actualizarlo!", también, si el id en el JSON es vacio entregará "El id está vacio. Por favor escribelo en el atributo del JSON.




