import 'package:colegio_bnnm/features/school/models/messages/chat/message_model.dart';

class BCalculator {
  // CHAT
  static bool isTheLast(int index, int total) {
    return total == index + 1;
  }

  static bool followingIsAlsoTheSame(int index, List<MessageModel> list) {
    return !isTheLast(index, list.length)
        ? list[index].likeAnother(list[index + 1])
        : false;
  }

  static bool hasTheDateInLessThanXMinutes(int index, List<MessageModel> list,
      {int minutes = 5}) {
    final isFirst = index == 0;
    if (!isFirst) {
      return list[index].date!.difference(list[index - 1].date!).inMinutes >
          minutes;
    }
    return isFirst;
  }

  //QUALIFICATIONS
  static String calculateAverage(List<double> qualifications) {
    double suma = qualifications.fold(0, (a, b) => a + b);
    double average = suma / qualifications.length;
    String averageRounded = average.toStringAsFixed(1);
    return averageRounded;
  }

  // UPDATE DETAILS
  static bool hasPassedOneMonth(DateTime? date) {
    final currentDate = DateTime.now();
    if (date == null) return true;
    date = date.subtract(const Duration(hours: 5));
    int differenceYears = currentDate.year - date.year;
    int differenceMonths =
        (differenceYears * 12) + (currentDate.month - date.month);

    return differenceMonths > 1 ||
        (differenceMonths == 1 && currentDate.day >= date.day);
  }
}
