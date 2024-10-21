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

  final _schoolService = SchoolService();

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

  final _urls = [
    CategoryModel.url,
    GenderModel.url,
    LevelModel.url,
    NewModel.url,
    AttendanceStatusModel.url,
    HomeworkStatusModel.url,
  ];

  Future<void> _getList(String url) async {
    final lists = [
      _categories,
      _genders,
      _levels,
      _news,
      _attendanceStatus,
      _homeworkStatus
    ];
    try {
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
            // SET CourseMapper
            course.value = CourseEnumMapper(valuesCourse);
          }
        }
      }
    } catch (e) {
      BLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

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
}
