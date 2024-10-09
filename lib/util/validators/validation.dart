import 'package:colegio_bnnm/util/formatters/formatter.dart';

class BValidator {
  // REGISTER
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Ingresar un correo electrónico";
    }
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegExp.hasMatch(value)) {
      return "Correo electrónico inválido";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "La contraseña es requerida";
    }
    if (value.length < 6) {
      return "La contraseña debe tener al menos 6 caracteres";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "La contraseña debe contener al menos una letra mayúscula";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "La contraseña debe contener al menos un número";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "La contraseña debe contener al menos un carácter especial";
    }
    return null;
  }

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "Falta rellenar el campo: $fieldName";
    }
    return null;
  }

  static String? validateNoSelection(String? fieldName, int? value) {
    if (value == null || value == 0) {
      return "No se ha seleccionado un elemento en la lista: $fieldName";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "El número de teléfono es requerido";
    }
    final phoneRegExp = RegExp(r'^\d{9}$');
    if (!phoneRegExp.hasMatch(value)) {
      return "Formato de número de teléfono no válido (se requieren 9 dígitos)";
    }
    return null;
  }

  static String? validateDate(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "Fecha de $fieldName requerida.";
    }
    try {
      BFormatter.correctFormatStringDate(value);
      // DateTime.parse(value);
    } catch (e) {
      if (e is FormatException) {
        return "La fecha no tiene un formato válido.";
      } else {
        return "No se reconoce la fecha";
      }
    }
    return null;
  }

  // NEWS
  static String? validateLength(int lenght, String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "El campo '$fieldName' no puede estar vacío.";
    }
    if (value.length > lenght) {
      return "No sobrepasar los $lenght caracteres";
    }
    return null;
  }

  // QUALIFICATION
  static String? validateQualification(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final qualificationRegExp = RegExp(r'^\d{0,2}(\.\d{0,1})?$');

    if (!qualificationRegExp.hasMatch(value) || double.parse(value) > 20) {
      return "Incorrect qualification";
    }
    return null;
  }
}
