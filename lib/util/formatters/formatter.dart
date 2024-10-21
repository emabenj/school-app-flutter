import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BFormatter {
  static String formatDateToString(DateTime? date, {bool normal = false}) {
    date ??= DateTime.now();
    String isoDate = date.toUtc().toIso8601String();
    return normal ? isoDate : DateFormat("dd-MM-yyyy").format(date);
  }

  static DateTime? formatStringToDate(String? dateString) {
    try {
      return dateString == null ? null : DateTime.parse(dateString);
    } catch (e) {
      if (e is FormatException) {
        // print("FORMATEADO DE FECHA");
      }
      throw Exception("FORMATEADO DE FECHA");
    }
  }

  static String correctFormatStringDate(String dateString) {
    return DateFormat("yyyy-MM-dd")
        .format(DateFormat("dd-MM-yyyy").parse(dateString));
  }

  // CHAT
  static String formatDateChat(DateTime date) {
    initializeDateFormatting('es_ES', null);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    date = date.subtract(const Duration(hours: 5));
    if (date.isAfter(today)) {
      return 'Hoy ${DateFormat('HH:mm').format(date)}';
    } else if (date.isAfter(yesterday)) {
      return 'Ayer ${DateFormat('HH:mm').format(date)}';
    } else {
      return DateFormat('d \'de\' MMM, HH:mm', 'es_ES').format(date);
    }
  }

  static String formatHour(DateTime? date) {
    initializeDateFormatting('es_ES', null);
    date ??= DateTime.now();
    date = date.subtract(const Duration(hours: 5));
    return DateFormat('HH:mm').format(date);
  }

  // REGISTER
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 9) {
      return "+51 $phoneNumber";
    }
    return phoneNumber;
  }

  static String formatName(String name, String lastname,
      {bool onlyName = false, bool separated = true}) {
    return "${reduceName(name)}${separated ? "\n" : " "}${onlyName ? lastname : reduceName(lastname)}";
  }

  static String reduceName(String name) {
    return "${name.substring(0, name.indexOf(" ") + 2)}.";
  }
  // NEWS

  static String formatViewCount(int total) {
    if (total > 1000) {
      return "${total ~/ 1000}k";
    } else if (total < 0) {
      return "0";
    } else {
      return total.toString();
    }
  }
  // ATTENDANCE

  static Color colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
