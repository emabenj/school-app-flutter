import 'package:colegio_bnnm/features/school/controllers/register_account/register_controller.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';

class TextSearch extends StatefulWidget {
  const TextSearch({super.key});

  @override
  State<TextSearch> createState() => _TextSearchState();
}

class _TextSearchState extends State<TextSearch> {
  final controller = RegisterController.instance;

  @override
  void initState() {
    super.initState();
    // controller.dniController.addListener(() {
    //   _filterStudents();
    // });
  }

  Future<void> _filterStudents() async {
    final dni = controller.dniController.text.trim();
    if (dni.length == 8) {
      await controller.searchStudent(dni);
      controller.dniController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller.dniController,
        onChanged: (value) => _filterStudents(),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: BTexts.registerFieldSearchA,
        ),
      ),
    );
  }
}
