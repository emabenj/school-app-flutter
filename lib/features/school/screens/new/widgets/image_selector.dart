import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_image_container.dart';
import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({super.key});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final ImagePicker _picker = ImagePicker();
  final controller = NewsController.instance;

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
        // prefixIcon: Icon(Icons.calendar_today),
        hintText: BTexts.uploadImg);

    return Column(
      children: [
        SizedBox(
            width: BHelperFunctions.screenWidth() * .3,
            child: TextField(
                controller: controller.imgController,
                decoration: decoration,
                readOnly: true,
                onTap: _selectedPicture)),
        const SizedBox(height: BSizes.spaceBtwInputFields),
        controller.imgFile != null
            ? SizedBox(
                width: BHelperFunctions.screenWidth() * .7,
                child: BorderedContainerImage(
                    radius: BRadiusStyles.all,
                    img: Image.network(controller.imgFile!.path)))
            : const Text('No hay imagen seleccionada.'),
      ],
    );
  }

  Future<void> _selectedPicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    controller.imgFile = pickedFile;

    if (pickedFile != null) {
      controller.imgController.text = pickedFile.name;
    } else {
      controller.imgController.text = "";
    }
    setState(() {});
  }
}
