import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/register_account/register_controller.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';

class ComboboxRegister extends StatefulWidget {
  const ComboboxRegister({super.key, required this.type});
  final CmbType type;

  @override
  State<ComboboxRegister> createState() => _ComboboxRegisterState();
}

class _ComboboxRegisterState extends State<ComboboxRegister> {
  final controller = ItemListController.instance;
  final registerController = RegisterController.instance;
  int? index;
  List<dynamic> labels = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Mover la lógica asíncrona a otro método
  Future<void> _loadData() async {
    labels = widget.type == CmbType.gender
        ? controller.gender.value.list()
        : await controller.getLevels();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final items = List.generate(labels.length, (index) {
        final item = labels[index];
        return getDropdowMenuItem(item.id, item.name);
      });

      final isGenderType = CmbType.gender == widget.type;

      return Expanded(
          child: DropdownButton(
              borderRadius: BorderRadius.circular(14),
              dropdownColor: Theme.of(context)
                  .dropdownMenuTheme
                  .menuStyle
                  ?.backgroundColor
                  ?.resolve({}),
              padding:
                  Theme.of(context).menuButtonTheme.style?.padding?.resolve({}),
              value: index,
              hint: Text(
                  isGenderType ? BTexts.registerGender : BTexts.registerLevel),
              onChanged: (newValue) {
                setState(() {
                  index = newValue;
                  if (widget.type == CmbType.level) {
                    final courses = controller.course.value.getCourses(newValue);
                    registerController.setItems(courses);
                  } else {
                    registerController.genderId.value = index??0;
                  }
                });
              },
              items: items));
    }
  }

  DropdownMenuItem getDropdowMenuItem(int index, String text) {
    String name = text[0].toUpperCase() + text.substring(1).toLowerCase();
    return DropdownMenuItem(value: index, child: Text(name));
  }
}

enum CmbType { gender, level }
