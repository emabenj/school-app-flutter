import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/common/widgets/groups/text_field_list.dart';
import 'package:colegio_bnnm/features/school/controllers/register_account/register_controller.dart';
import 'package:colegio_bnnm/features/school/screens/register_account/widgets/birthday_field_register.dart';
import 'package:colegio_bnnm/features/school/screens/register_account/widgets/cmb_register.dart';
import 'package:colegio_bnnm/features/school/screens/register_account/widgets/item_list_register.dart';
import 'package:colegio_bnnm/features/school/screens/register_account/widgets/text_search.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:colegio_bnnm/util/mappers/authentication_mapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key, required this.type});

  final String type;

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  final controller = Get.put(RegisterController());

  late bool forT;
  late List<Widget> items;
  @override
  void initState() {
    super.initState();
    forT = BAuthMapper.role(widget.type) == Roles.teacher;
  }

  @override
  Widget build(BuildContext context) {
    items = TextFieldList(
            validators: controller.validators,
            labels: BTexts.fieldsRegister,
            controllers: controller.controllers,
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                color: BHelperFunctions.isDarkMode(context)
                    ? BColors.white
                    : BColors.black))
        .get();
    if (forT) {
      items.add(const SizedBox(height: BSizes.spaceBtwInputFields));
      items.add(const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BirthdayFieldRegister(),
            SizedBox(width: BSizes.sm),
            ComboboxRegister(type: CmbType.gender)
          ]));
    }
    return Scaffold(
        appBar: BAppBar(
            showBackArrow: true,
            title: Text(forT ? BTexts.registerTitleT : BTexts.registerTitleA,
                style: Theme.of(context).textTheme.headlineMedium)),
        body: SingleChildScrollView(
            child: Padding(
                padding: BSpacingStyles.paddingWithOutAppBarHeight,
                //FORM
                child: Form(
                    key: controller.registerFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...items,
                          const SizedBox(height: BSizes.spaceBtnSections),
                          SizedBox(
                              height: BHelperFunctions.screenHeight() * .08,
                              width: BHelperFunctions.screenWidth() * .44,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(forT
                                        ? BTexts.registerSearchT
                                        : BTexts.registerSearchA),
                                    const SizedBox(
                                        height: BSizes.spaceBtwInputFields),
                                    forT
                                        ? const ComboboxRegister(
                                            type: CmbType.level)
                                        : const TextSearch()
                                  ])),
                          const SizedBox(height: BSizes.spaceBtwInputFields),
                          ItemListRegister(forT: forT),
                          const SizedBox(height: BSizes.spaceBtwItems),
                          BElevatedButton(
                              onPressed: () => controller.register(),
                              text: BTexts.registerBtn)
                        ])))));
  }
}
