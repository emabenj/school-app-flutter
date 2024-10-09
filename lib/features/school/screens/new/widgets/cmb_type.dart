import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/item_dropdown/category_model.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';

class CmbCategorie extends StatefulWidget {
  const CmbCategorie({super.key});

  @override
  State<CmbCategorie> createState() => _CmbCategorieState();
}

class _CmbCategorieState extends State<CmbCategorie> {
  final controller = NewsController.instance;
  late List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();
    categories = ItemListController.instance.newsCategory.value.list();
  }

  int? index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: BHelperFunctions.screenWidth()*.81,
      child: DropdownButtonFormField(
          validator: (value) =>
              BValidator.validateNoSelection("Categoría", value),
          borderRadius: BorderRadius.circular(BSizes.borderRadiusLg),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          value: index,
          hint: const Text(BTexts.select),
          onChanged: (newValue) {
            setState(() {
              index = newValue;
              controller.indexCategory.value = newValue ?? 0;
            });
          },
          items: List.generate(
              categories.length,
              (index) => DropdownMenuItem(
                  value: categories[index].id,
                  child: Text(categories[index].name)))),
    );
  }
}
