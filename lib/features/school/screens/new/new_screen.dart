import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/cmb_type.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/image_selector.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/lengths.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:colegio_bnnm/util/validators/validation.dart';
import 'package:flutter/material.dart';

class NewsControlScreen extends StatelessWidget {
  const NewsControlScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = NewsController.instance;

    final insert = controller.isInserting();
    final dark = BHelperFunctions.isDarkMode(context);

    final bgContainer = dark ? BColors.light : BColors.dark;
    final styleContainer = BoxDecoration(
        borderRadius: BorderRadius.circular(50), color: bgContainer);
    final titleStyle = Theme.of(context).textTheme.headlineSmall!;

    final w = BHelperFunctions.screenWidth();
    final h = BHelperFunctions.screenHeight();

    return Scaffold(
        appBar: BAppBar(
            showBackArrow: true,
            title: Text(insert ? BTexts.addN : BTexts.editN,
                style: Theme.of(context).textTheme.headlineMedium)),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(BSizes.sm),
                child: Form(
                  key: controller.newsFormKey,
                  child: Column(children: [
                    // IMG 250h -- CONTAINER 400w x 300h
                    Container(
                        decoration: styleContainer,
                        child: Image(
                            image: const AssetImage(BImages.newHead),
                            width: w * .9,
                            height: h * .3)),
                    const SizedBox(height: BSizes.spaceBtwItems),
                    // TITLE 350w
                    //TEXT
                    Text(BTexts.newTitle, style: titleStyle),
                    const SizedBox(height: BSizes.sm),
                    //TEXTFIELD
                    SizedBox(
                        width: w * .81,
                        child: TextFormField(
                          validator: (value) => BValidator.validateLength(BLength.title, "Título", value),
                            controller: controller.titleController)),
                    const SizedBox(height: BSizes.spaceBtwItems),
                    // DESCRIPTION  350w
                    //TEXT
                    Text(BTexts.newDescription, style: titleStyle),
                    const SizedBox(height: BSizes.sm),
                    //TEXTFIELD
                    SizedBox(
                        width: w * .81,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 4,
                          validator: (value) => BValidator.validateEmptyText("Descripción", value),
                            controller: controller.descriptionController)),
                    const SizedBox(height: BSizes.sm),
                    // SELECT CATEGORY 180w
                    //TEXT
                    Text(BTexts.selectCategory, style: titleStyle),
                    const SizedBox(height: BSizes.sm),
                    //TEXTFIELD
                    const CmbCategorie(),
                    const SizedBox(height: BSizes.sm),
                    // UPLOAD AN IMAGE (OPTIONAL) 130w
                    const ImageSelector(),
                    const SizedBox(height: BSizes.spaceBtwInputFields),
                    // BUTTON
                    BElevatedButton(
                      
                        text: insert ? BTexts.newBtnA : BTexts.newBtnE,
                        onPressed: () => controller.actionCrud())
                  ]),
                ))));
  }
}
