import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/buttons/custom_elevated_button.dart';
import 'package:colegio_bnnm/common/widgets/groups/widget_list.dart';
import 'package:colegio_bnnm/common/widgets/loaders/loaders.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/features/personalization/controllers/update_details/update_details_controller.dart';
import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class UpdateDetailsScreen extends StatefulWidget {
  const UpdateDetailsScreen({super.key});

  @override
  State<UpdateDetailsScreen> createState() => _UpdateDetailsScreenState();
}

class _UpdateDetailsScreenState extends State<UpdateDetailsScreen> {
  final controller = Get.put(UpdateDetailsController());
  bool allowToUpdate = true;
  late List<String? Function(String?)> validators;
  late List<TextEditingController> controllers;
  @override
  void initState() {
    super.initState();
    controllers = controller.getControllers();
    validators = controller.validators;
    allowToUpdate = AuthenticationRepository.instance.allowToUpdateDetails();
    if (!allowToUpdate) {
      // Mostrar el SnackBar después de que la pantalla se haya construido
      SchedulerBinding.instance.addPostFrameCallback((_) {
        BLoaders.customToast(
          message: "Solo puedes actualizar tu información, una vez por mes.",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> textForms = BWidgetList(
            widgets: List.generate(
                controller.labels.length,
                (index) => TextFormField(
                    enabled: allowToUpdate,
                    validator: validators[index],
                    controller: controllers[index],
                    decoration:
                        InputDecoration(labelText: controller.labels[index]))))
        .get();

    return Scaffold(
        appBar: BAppBar(
            showBackArrow: true,
            title: Text(BTexts.updateDBarTitle,
                style: Theme.of(context).textTheme.headlineMedium)),
        body: SingleChildScrollView(
            child: Padding(
                padding: BSpacingStyles.paddingWithAppBarHeight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Ink.image(
                          width: BHelperFunctions.screenWidth() * .81,
                          height: BHelperFunctions.screenHeight() * .16,
                          image: const AssetImage(BImages.updateDetailsHead)),
                      Form(
                          key: controller.updateDetailsFormKey,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: BSizes.spaceBtnSections),
                              child: Column(children: textForms))),
                      BElevatedButton(
                          onPressed:
                              allowToUpdate ? controller.updateDetails : null,
                          text: BTexts.saveChanges)
                    ]))));
  }
}
