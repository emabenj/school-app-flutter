enum TextSizes { small, medium, large }

enum Roles { admin, teacher, authorised, user }

enum Courses {
  artPRIMARY,
  englishPRIMARY,
  historyPRIMARY,
  languagePRIMARY,
  mathPRIMARY,
  naturalSciencePRIMARY,
  physicalEducationPRIMARY,
  artSECONDARY,
  englishSECONDARY,
  historySECONDARY,
  languageSECONDARY,
  mathSECONDARY,
  naturalScienceSECONDARY,
  physicalEducationSECONDARYY
}

enum Crud { insert, edit, remove, search }

enum NewsState { reduced, expanded }

enum Rounded {
  upLg,
  upMd,
  down,
  chatLLg,
  chatRLg,
  chatLMd,
  chatRMd,
  backChatLLg,
  backChatRLg,
  backChatLMd,
  backChatRMd,
  all,
  diagonalBottom,
  diagonalTop
}

enum Positions { outBottom, outTop, center }

// SELECT SCREEN
enum StatusSelection {
  room,
  rooms,
  student,
  messagesToParents,
  messagesToTeachers,
  selHomework,
  selQualifications,
  selAttendance
}

// QUALIFICATIONS
enum StudentsGradeStatus { approved, disapproved, undetermined }

// LEVELS
enum Levels { primary, secondary }

// GENDERS
enum Genders { male, female }

// ATTENDANCE
enum AttendanceStatus { attended, absent, isLate, isGone, retirated } // CHANGE

// HOMEWORK
enum HomeworkStatus { unqualified, underRevision, rated }

// MESSAGES
enum MessagesStatus { sending, selecting, teachersList, parentsList }


