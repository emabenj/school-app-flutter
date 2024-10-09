import 'package:colegio_bnnm/features/school/controllers/register_account/register_controller.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';

class BirthdayFieldRegister extends StatefulWidget {
  const BirthdayFieldRegister({super.key});

  @override
  State<BirthdayFieldRegister> createState() => _BirthdayFieldRegisterState();
}

class _BirthdayFieldRegisterState extends State<BirthdayFieldRegister> {
  final controller = RegisterController.instance;
  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: BTexts.registerBirthday);

    return Expanded(
      flex: 2,
      child: TextField(
          controller: controller.birthDateController,
          decoration: decoration,
          readOnly: true,
          onTap: _selectedDate),
    );
  }

  Future<void> _selectedDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2024 - 50),
        lastDate: DateTime(2024 - 20));
    if (picked != null) {
      setState(() {
        controller.birthDateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
