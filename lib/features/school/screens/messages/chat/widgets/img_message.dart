import 'package:colegio_bnnm/common/widgets/containers/image_with_lootie_placeholder.dart';
import 'package:colegio_bnnm/common/styles/radius_styles.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_image_container.dart';
import 'package:colegio_bnnm/features/school/models/messages/chat/imagen_conversation_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ImagenMessage extends StatelessWidget {
  final List<ImagenConversationModel> imagenes;
  const ImagenMessage({super.key, required this.imagenes});

  @override
  Widget build(BuildContext context) {
    final bool hasImgs = imagenes.isNotEmpty;
    const url = APIConstants.url;
    final urlImg = hasImgs ? url + imagenes[0].link : "";
    return hasImgs
        ? SizedBox(
            width: BHelperFunctions.screenWidth() * .5,
            child: BorderedContainerImage(
                radius: BRadiusStyles.all,
                img: ImageWithLottiePlaceholder(imageUrl: urlImg)),
          )
        : const SizedBox();
  }
}
