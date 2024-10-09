import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/services/school/school_service.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/attendance_status_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/category_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/gender_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/homework_status_model.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/level_model.dart';
import 'package:colegio_bnnm/features/school/models/new/new_model.dart';
import 'package:colegio_bnnm/features/school/models/register_account/course_model.dart';
import 'package:colegio_bnnm/util/mappers/attendance_enum_mapper.dart';
import 'package:colegio_bnnm/util/mappers/course_enum_mapper.dart';
import 'package:colegio_bnnm/util/mappers/gender_enum_mapper.dart';
import 'package:colegio_bnnm/util/mappers/homework_enum_mapper.dart';
import 'package:colegio_bnnm/util/mappers/news_category_enum_mapper.dart';
import 'package:get/get.dart';

class ItemListController extends GetxController {
  static ItemListController get instance => Get.find();
  // VARIABLES

  final _categories = Rx<List<dynamic>>([]);
  final _genders = Rx<List<dynamic>>([]);
  final _levels = Rx<List<dynamic>>([]);
  final _attendanceStatus = Rx<List<dynamic>>([]);
  final _homeworkStatus = Rx<List<dynamic>>([]);

  final newsCategory = NewsCategoryEnumMapper.empty().obs;
  final gender = GenderEnumMapper.empty().obs;
  final attendance = AttendanceEnumMapper.empty().obs;
  final homework = HomeworkEnumMapper.empty().obs;
  final course = CourseEnumMapper.empty().obs;

  final _courses = Rx<Map<int, List<CourseModel>>>({});
  final _news = Rx<List<dynamic>>([]);

  final _schoolService = SchoolService();

  final _urls = [
    CategoryModel.url,
    GenderModel.url,
    LevelModel.url,
    NewModel.url,
    AttendanceStatusModel.url,
    HomeworkStatusModel.url,
  ];

  Future<void> _getList(String url) async {
    try {
      final lists = [
        _categories,
        _genders,
        _levels,
        _news,
        _attendanceStatus,
        _homeworkStatus
      ];
      final typeIndex = _urls.indexOf(url);
      bool isEmpty = lists[typeIndex].value.isEmpty;
      if (isEmpty) {
        final values = await _schoolService.getList(url);
        lists[typeIndex].value = values;

        if (url == NewModel.url) {
          if (_categories.value.isEmpty) {
            await _getList(CategoryModel.url);
            newsCategory.value = NewsCategoryEnumMapper(_categories.value);
          }
          if (_genders.value.isEmpty) {
            await _getList(GenderModel.url);
            gender.value = GenderEnumMapper(_genders.value);
          }
          if (_courses.value.keys.isEmpty) {
            final valuesCourse = await _schoolService.getList(CourseModel.url)
                as List<CourseModel>;
            for (var course in valuesCourse) {
              if (course.levelId == null) {
                continue;
              }
              if (!_courses.value.containsKey(course.levelId!)) {
                _courses.value[course.levelId!] = [];
              }
              _courses.value[course.levelId]!.add(course);
            }
            // ESTABLECER CourseMapper
            course.value = CourseEnumMapper(valuesCourse);
          }
        }
      }
    } catch (e) {
      BLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  // CATEGORIES

  // List<CategoryModel> getCategories() {
  //   return _categories.value as List<CategoryModel>;
  // }

  // CategoryModel getCategory(int id) {
  //   return getCategories().firstWhereOrNull((cat) => cat.id == id) ??
  //       CategoryModel.empty();
  // }

  // int getCategoryIndex(int id) {
  //   final categoryList = getCategories();
  //   return categoryList.indexWhere((cat) => cat.id == id);
  // }

  // GENDERS

  // List<GenderModel> getGenders() {
  //   return _genders.value as List<GenderModel>;
  // }

  // String getGenderImage(int id) {
  //   final index = _genders.value.indexWhere((gender) => gender.id == id);
  //   return _gendersImages[index];
  // }

  // LEVELS

  Future<List<LevelModel>> getLevels() async {
    await _getList(LevelModel.url);
    return _levels.value as List<LevelModel>;
  }

  // NEWS

  Future<List<NewModel>> getNews() async {
    await _getList(NewModel.url);
    return _news.value as List<NewModel>;
  }

  // COURSES

  // List<CourseModel> getCourses(int level) {
  //   return _courses.value[level] ?? [];
  // }

  // ATTENDANCE

  Future<void> getAttendanceStatus() async {
    await _getList(AttendanceStatusModel.url);
    attendance.value = AttendanceEnumMapper(_attendanceStatus.value);
  }

  // HOMEWORK

  Future<void> getHomeworkStatus() async {
    await _getList(HomeworkStatusModel.url);
    homework.value = HomeworkEnumMapper(_homeworkStatus.value);
  }

  // List<AttendanceStatusModel> listAttendanceStatus() {
  //   return attendance.value as List<AttendanceStatusModel>;
  // }

  // List<AttendanceStatusModel> listAttendanceToSelect() {
  //   final statusList = listAttendanceStatus();
  //   final statusToSelect = statusList.sublist(0, statusList.length - 1);
  //   return statusToSelect;
  // }

  // AttendanceStatusModel getAttendanceStatusModel(int id) {
  //   return listAttendanceStatus()
  //           .firstWhereOrNull((status) => status.id == id) ??
  //       AttendanceStatusModel.empty();
  // }

  // bool isRetired(int id) {
  //   return getAttendanceStatusIdByEnum(AttendanceStatus.retirated) == id;
  // }

  // int getAttendanceStatusIdByEnum(AttendanceStatus status) {
  //   final index = AttendanceStatus.values.indexOf(status);
  //   return listAttendanceStatus()[index].id;
  // }

  // List<HomeworkStatusModel> listHomeworkStatus() {
  //   return homework.value as List<HomeworkStatusModel>;
  // }

  // List<HomeworkStatusModel> listHomeworkToSelect() {
  //   final statusList = listHomeworkStatus();
  //   final statusToSelect = statusList.sublist(0, statusList.length - 1);
  //   return statusToSelect;
  // }

  // HomeworkStatusModel getHomeworkStatusModel(int id) {
  //   return listHomeworkStatus().firstWhereOrNull((status) => status.id == id) ??
  //       HomeworkStatusModel.empty();
  // }

  // bool isRetired(int id) {
  //   return getHomeworkStatusIdByEnum(HomeworkStatus.retirated) == id;
  // }

  // int getHomeworkStatusIdByEnum(HomeworkStatus status) {
  //   final index = HomeworkStatus.values.indexOf(status);
  //   return listHomeworkStatus()[index].id;
  // }
}
