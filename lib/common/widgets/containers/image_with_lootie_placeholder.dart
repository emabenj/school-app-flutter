import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImageWithLottiePlaceholder extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const ImageWithLottiePlaceholder(
      {super.key, required this.imageUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: height,
          width: width,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              // If the picture is already loaded, display the picture
              return child;
            } else {
              // While the image is loading, show the Lottie animation
              return Center(
                child: Lottie.asset(
                  BImages.loadingImagen,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            // Error handling: show an icon if the image fails to load
            return const Center(child: Icon(Icons.error, color: Colors.red));
          },
        ),
      ],
    );
  }
}
