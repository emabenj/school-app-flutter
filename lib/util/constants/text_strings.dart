import 'package:colegio_bnnm/util/constants/enums.dart';

class BTexts {
  // GLOBAL
  static const fieldEmail = "Correo electrónico";
  static const fieldNumber = "Número";
  static const fieldAddress = "Dirección";
  static const fieldName = "Nombres";
  static const fieldLastName = "Apellidos";
  static const fieldDNI = "DNI";
  static const fieldDate = "dd/MM/yyyy";
  static const saveChanges = "Guardar cambios";
  static const saveChangesSalto = "Guardar\ncambios";

  static const select = "Seleccionar";

  static const fieldsRegister = [
    fieldName,
    fieldLastName,
    fieldEmail,
    fieldNumber,
    fieldAddress
  ];

  // MESSAGES ERRORS
  static const noServerConnectionTitle ="No hay conexión";
  static const noServerConnectionMessage =
      "Esperar un momento mientras intentamos conectar con el servidor";
  static const titleNoServerConnection = "No hay conexión con el servidor";
  static const sessionClosed = "Se cerró la sesión";

  // ON BOARDING
  static const onBoardingTitle1 = "Gestión eficiente del colegio";
  static const onBoardingTitle2 = "Comunicación fluida con los docentes";
  static const onBoardingTitle3 = "Participación activa de los apoderados";

  static const onBoardingSubTitle1 = "Administra aulas, docentes y estudiantes de manera centralizada. Mantén toda la información actualizada y accesible desde cualquier lugar.";
  static const onBoardingSubTitle2 = "Los docentes pueden asignar tareas, gestionar aulas y calificaciones, y comunicarse con los apoderados de forma directa y rápida.";
  static const onBoardingSubTitle3 = "Recibe notificaciones sobre el progreso académico, actualiza tus datos y mantente informado de las noticias importantes del colegio.";

  // DEVICE STORAGE
  static const keyFirstTime = "IsFirstTime";
  static const keyRememberEmail = "REMEMBER_ME_EMAIL";
  static const keyRememberPass = "REMEMBER_ME_PASSWORD";
  static const keyRememberToken = "REMEMBER_ME_TOKEN";
  static const keyRememberRole = "REMEMBER_ME_ROLE";
  static const keyTeacherSending = "TEACHER_SENDING";

  // HOME
  static const home = "Inicio";
  static const homeWelcome = "Bienvenido/a, ";

  static const genderList = ['Masculino', 'Femenino'];
  static const levelList = ['Primaria', 'Secundaria'];

  // DRAWER
  static const listAdmin = [
    "Publicar noticia",
    "Registrar apoderado",
    "Registrar docente"
  ];
  static const listAuthorised = ["Comunicación con docentes", "Perfil"];
  static const listTeacher = [
    "Asistencia",
    "Calificaciones",
    "Tareas",
    "Comunicación con padres",
    "Perfil"
  ];
  static const drawerActionList = [listAdmin, listTeacher, listAuthorised, []];

  static drawerActions(Roles role) =>
      drawerActionList[Roles.values.indexOf(role)];

  // LOGIN
  static const loginTitle = "Accede a tu cuenta";
  static const loginSubTitle = "Bienvenido/a de nuevo.";
  static const fieldPassword = "Contraseña";
  static const loginRemeberMe = "Mantener sesión";
  static const loginForget = "¿Olvidaste tu contraseña?";
  static const loginBtn = "Ingresar";
  static const loginStill = "¿Todavía no tienes tu cuenta?";
  static const loginSeeNews = "Ver noticias";
  static const roleList = ["Administrador", "Docente", "Apoderado", "Invitado"];

  // RESET PASSWORD
  static const resetTitle = "Contraseña olvidada";
  static const resetSubTitle =
      "Por favor, ingresar su correo electrónico para recibir el link de verificación para restablecer su contraseña.";
  static const resetBtn = "Enviar correo";

  // UPDATE DETAILS
  static const updateDBarTitle = "Información de contacto";
  static const updateDTitle = "Mantén tus datos actualizados";

  static const updateFields = [fieldEmail, fieldNumber, fieldAddress];

  // REGISTER TEACHER - AUTHORISED
  static const registerTitleA = "Registrar Apoderado";
  static const registerTitleT = "Registrar Docente";
  static const registerSearchA = "Buscar estudiante";
  static const registerSearchT = "Asignar curso";
  static const registerFieldSearchA = "Ingresar $fieldDNI";
  static const registerFieldSearchT = "Nivel educativo";
  static const registerBtn = "Registrar";
  static const registerLevel = "Nivel educativo";
  static const registerGender = "Género...";
  static const registerBirthday = "Fecha de nacimiento";

  static const coursesList = [
    "Arte",
    "Inglés",
    "Historia",
    "Lengua",
    "Matemática",
    "Ciencias Naturales",
    "Educación Física"
  ];
  static String courses(Courses course) =>
      coursesList[Courses.values.indexOf(course)];

  // NEWS
  static const addN = "Agregar noticia";
  static const newBtnA = "Publicar";
  static const editN = "Editar noticia";
  static const newBtnE = "Actualizar";
  static const newTitle = "¿Cuál será el título de la noticia?";
  static const newDescription = "¿Qué irá en la descripción?";
  static const selectCategory = "Elige una categoría";
  static const uploadImg = "Subir imagen";
  static const categories = [
    "Logros estudiantiles",
    "Eventos escolares",
    "Actualizaciones del personal",
    "Políticas y procedimientos",
    "Proyectos y programas educativos",
    "Orientación y consejería",
    "Actualizaciones de infraestructura",
    "Eventos de recaudación de fondos",
    "Noticias de la comunidad"
  ];
  // SELECT ROOM - STUDENT
  static const selectBtn1 = "Seleccionar aulas";
  static const selectBtn2 = "Seleccionar aulas...";
  static const selectTitleForT = "Aulas";
  static const selectTitleForA = "Estudiantes";
  static const selectWithoutAuthorised = "No hay apoderados conectados";
  static const allOnlineAuthorised = "Todos los usuarios en línea";
  static const selectWithoutTeachers = "No hay profesores conectados";
  static const allOnlineTeachers = "Todos los profesores en línea";
  static const selectLevelP = "Nivel educativo - Primaria";
  static const selectLevelS = "Nivel educativo - Secundaria";

  // QUALIFICATIONS
  static const qualification = "Nota";
  static const finalQualification = "Nota final:";
  static const approved = "Aprobado";
  static const disapproved = "Desaprobado";
  static const undetermined = "Indeterminado";

  // HOMEWORK
  static const homeworkTitle = "Tareas";
  static const homeworkLabelDescription = "Ingresar descripción";
  static const homeworkLabelDate = "Fecha de entrega";
  static const homeworkPrevious = "Anteriores";
  static const homeworkRemoveConfirm = "¿Estás seguro de eliminar esta tarea?";

  static const homeworkList = ['Sin calificar', 'En revisión', 'Calificada'];

  // ATTENDANCE
  static const attendanceTime = "La clase termina en ";// CHANGE
  static const attendanceTimeNumber = "54 minutos";// CHANGE
  static const attendanceDate = "Fecha: 20/08/2024";// CHANGE
  static const attendanceSelectAll = "Asistieron todos";
  static const attendanceList = [
    'Asistio',
    'Falto',
    'Tarde',
    'Salio',
    'Retirado'
  ];

  // MESSAGES-SELECT
  static const messageRecent = "Recientes";
  static const messageButtonSend = "Enviar a varios";
  static const messageButtonSee = "Ver todos";

  // MESSAGES-CHAT
  static const chatLabel = "Ingresar mensaje";
  static const chatButton = "Enviar";
  static const online = "En línea";
  static const offline = "Desconectado";
}
