import 'package:colegio_bnnm/util/constants/image_strings.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Image(
        height: 120,
        image: AssetImage(BImages.admin),
      ),
      Text(BTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: BSizes.sm),
      Text(BTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
    ]);
  }
}
