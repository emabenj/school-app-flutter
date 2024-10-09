import 'package:colegio_bnnm/util/constants/enums.dart';

class BImages {
  // APP LOGOS
  static const darkAppLogo = "";
  static const lightAppLogo = "";

  // LOTTIE
  static const loadingAnimation1 = "assets/images/lotties/book.json";
  
  static const loadingImagen = "assets/images/lotties/loader.json";
  static const loadingRegister = "assets/images/lotties/register_animation.json";
  static const loadingAttendance = "assets/images/lotties/attendance_animation.json";
  static const loadingQualifications = "assets/images/lotties/register_animation.json";
  static const loadingLoginCheck = "assets/images/lotties/login_check_animation.json";
  static const loadingLoginLoading = "assets/images/lotties/login_loading_animation.json";
  static const loadingSearchStudent = "assets/images/lotties/person.json";
  // ONBOARDING IMAGES

  static const onBoardingImage1 = "assets/images/on_boarding_images/onboarding_screen_1.png";
  static const onBoardingImage2 = "assets/images/on_boarding_images/onboarding_screen_2.png";
  static const onBoardingImage3 = "assets/images/on_boarding_images/onboarding_screen_3.png";

  // ROLES
  static const admin = "assets/images/admin.png";
  static const authorised = "assets/images/authorised.png";
  static const teacher = "assets/images/teacher.png";
  static const user = "assets/images/user.png";

  static const roleList = [admin, teacher, authorised, user];
  static String roles(Roles role) => roleList[Roles.values.indexOf(role)];

  // HEAD
  static const newHead = "assets/images/news.png";
  static const updateDetailsHead = "assets/images/update_details.png";

  // ICON CRUD
  static const insert = "assets/images/crud_1.png";
  static const edit = "assets/images/crud_2.png";
  static const delete = "assets/images/crud_3.png";
  static const delete2 = "assets/images/delete.png";
  static const delete3 = "assets/images/delete2.png";
  static const search = "assets/images/crud_4.png";

  static const cancel = "assets/images/cancel.png";
  // NEWS
  static const crudNews = [BImages.edit, BImages.delete];

  //ACTIONS FOR TEACHER
  static const send = "assets/images/send.png";
  static const homework = "assets/images/homework.png";
  static const qualifications = "assets/images/qualifications.png";

  // STUDENT GENDERS
  static const male = "assets/images/estudiantem.png";
  static const female = "assets/images/estudiantef.png";

  // COURSES
  static const coursePath = "assets/images/course";

  // LIST IMGS
  static const List<String> forAClassroom = [send, homework, qualifications];
  static const List<String> forClassrooms = [send, homework];
  static const List<String> crudHomework = [send, edit, delete];
  static const List<String> forSendingMessage = [cancel, send, delete3];
}
