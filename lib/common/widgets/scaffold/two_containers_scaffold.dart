import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_container.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TwoContainerScaffold extends StatelessWidget {
  const TwoContainerScaffold({super.key, required this.modelScaffold});
  final ForScaffoldModel modelScaffold;

  @override
  Widget build(BuildContext context) {
    final height =
        BHelperFunctions.screenHeight() * .26;
    return Scaffold(
        appBar: BAppBar(
            showBackArrow: true,
            title: Text(modelScaffold.title1,
                style: Theme.of(context).textTheme.headlineLarge)),
        body: SingleChildScrollView(
            child: Padding(
                padding: BSpacingStyles.paddingWithOutAppBarHeight,
                child: Column(children: [
                  // CONTAINER 1
                  BRoundedContainer(
                      padding: const EdgeInsets.all(BSizes.sm),
                      backgroundColor: modelScaffold.backgroundColorW1,
                      size: Size(double.infinity, height),
                      child: modelScaffold.widget1),
                  const SizedBox(height: BSizes.sm),
                  // TITLE 2
                  Text(modelScaffold.title2,
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: BSizes.sm),
                  // CONTAINER 2
                  BRoundedContainer(
                      backgroundColor: modelScaffold.backgroundColorW2,
                      size: Size(double.infinity,
                          BHelperFunctions.screenHeight() * .56),
                      child: modelScaffold.widget2)
                ]))));
  }
}

class ForScaffoldModel {
  const ForScaffoldModel(this.title1, this.title2, this.widget1, this.widget2,
      this.backgroundColorW1, this.backgroundColorW2);

  final String title1;
  final String title2;
  final Widget widget1;
  final Color backgroundColorW1;
  final Widget widget2;
  final Color backgroundColorW2;
}
