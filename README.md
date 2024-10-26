# School APP
**Aplicación Móvil para Gestión Escolar**

## Descripción
Esta aplicación educativa permite la gestión de usuarios (Apoderados, Docentes, Administradores e Invitados) en un entorno móvil, facilitando el acceso a noticias, mensajería en tiempo real, gestión de aulas, cursos, calificaciones, tareas y asistencia. El backend está desarrollado en Django (ver repositorio [Colegio API](https://github.com/emabenj/colegio-api-django)) y el frontend en Flutter.

## Características
- **Roles de Usuario**: Apoderado, Docente y Administrador.
- **Gestión de Noticias**: Noticias categorizadas y con imágenes por defecto.
- **Mensajería en Tiempo Real**: Comunicación entre apoderados y docentes mediante WebSockets.
- **Gestión Académica**: Asignación de cursos y aulas, calificaciones, asistencia y tareas.
- **API REST**: API para manejar datos en el frontend móvil y en web.

## Instalación

1. Asegúrate de tener Flutter instalado. Sigue las instrucciones en [Flutter Install](https://flutter.dev/docs/get-started/install).

2. Clona este repositorio:
    ```bash
    git clone https://github.com/emabenj/school-app-flutter
    ```
3. Entra a la carpeta del proyecto Flutter:
    ```bash
    cd school-app-flutter
    ```
3. Instala las dependencias:
    ```bash
    flutter pub get
    ```
###Backend (opcional)
Para correr el backend localmente, clona el repositorio de Django y sigue las instrucciones en su README.

## Uso

1. Ejecuta:
    ```bash
    flutter run
    ```

## Funcionalidades
### Noticias
Las noticias se crean desde el rol de administrador, y pueden ser visualizadas por todos los usuarios. Las categorías de noticias incluyen imágenes predeterminadas cuando no se agrega una específica.

### Gestión de Usuarios y Aulas
- Los administradores pueden registrar apoderados y docentes.
- Los apoderados se registran con un DNI asociado a al menos un estudiante registrado en un aula específica.

### Mensajería en Tiempo Real
Implementada mediante WebSockets para permitir la comunicación entre apoderados y docentes de forma instantánea.
