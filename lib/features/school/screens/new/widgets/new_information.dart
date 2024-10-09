import 'package:colegio_bnnm/common/widgets/containers/image_with_lootie_placeholder.dart';
import 'package:colegio_bnnm/common/widgets/containers/rounded_image_container.dart';
import 'package:colegio_bnnm/features/school/controllers/item_list_controller.dart';
import 'package:colegio_bnnm/features/school/models/new/new_model.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/type_time_new.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/view_counter.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';

class NewInfo extends StatelessWidget {
  const NewInfo(
      {super.key, this.state = NewsState.reduced, required this.model});

  final NewsState state;
  final NewModel model;

  @override
  Widget build(BuildContext context) {
    final pressed = state == NewsState.expanded;
    final dark = BHelperFunctions.isDarkMode(context);

    final background = pressed
        ? (dark ? BColors.black : BColors.white)
        : (dark ? BColors.dark : BColors.light);
    final border = pressed
        ? dark
            ? BColors.white
            : BColors.black
        : BColors.grey;

    final styleTitle = pressed
        ? Theme.of(context).textTheme.headlineMedium!
        : Theme.of(context).textTheme.titleMedium!;
    final styleContent = pressed
        ? Theme.of(context).textTheme.headlineSmall!
        : Theme.of(context).textTheme.bodyMedium!;
    final styleDetails = pressed
        ? Theme.of(context).textTheme.bodyMedium!
        : Theme.of(context).textTheme.labelMedium!;
    styleDetails.apply(color: BColors.grey);
    return Padding(
        // color: background,
        padding: EdgeInsets.all(pressed ? BSizes.md : BSizes.sm),
        child: pressed
            ? Ink(
                // width: BHelperFunctions.screenWidth() * .92,
                height: BHelperFunctions.screenHeight() * .7,
                child: Column(children: [
                  // Header
                  Expanded(
                    child: Text(model.title,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: styleTitle),
                  ),
                  const SizedBox(height: BSizes.sm),
                  // Content
                  Column(children: [
                    SizedBox(
                        child: Text(model.content,
                            textAlign: TextAlign.justify,
                            maxLines: 10,
                            style: styleContent)),
                    const SizedBox(height: BSizes.spaceBtwItems),
                    TypeTimeNew(
                        type: ItemListController
                            .instance.newsCategory.value.mapper
                            .getModelById(model.category)
                            .name,
                        time: model.formattedDateTime,
                        style: styleDetails),
                    const SizedBox(height: BSizes.spaceBtwItems),
                    SizedBox(
                        height: BHelperFunctions.screenHeight() * .37,
                        child: Stack(children: [
                          BorderedContainerImage(
                            img: model.hasImg()
                                ? ImageWithLottiePlaceholder(
                                    imageUrl: model.getImg(),
                                    width: BHelperFunctions.screenWidth() * .9,
                                    height:
                                        BHelperFunctions.screenHeight() * .37)
                                : Image(
                                    image: AssetImage(model.getImg()),
                                    height:
                                        BHelperFunctions.screenHeight() * .37),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: SizedBox(
                                width: BHelperFunctions.screenWidth() * .12,
                                child: ViewCounter(
                                    style: styleDetails,
                                    views:
                                        BFormatter.formatViewCount(model.views),
                                    borderColor: border,
                                    backgroundColor: background),
                              ))
                        ]))
                  ])
                ]))
            : Ink(
                child: Column(children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 6,
                        child: Text(model.title,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: styleTitle)),
                    const SizedBox(width: BSizes.xs),
                    Expanded(
                      child: ViewCounter(
                          style: styleDetails,
                          views: BFormatter.formatViewCount(model.views),
                          borderColor: border,
                          backgroundColor: background),
                    )
                  ],
                ),
                const SizedBox(height: BSizes.xs),
                // Content
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Expanded(
                    flex: 2,
                    child: model.hasImg()
                        ? ImageWithLottiePlaceholder(imageUrl: model.getImg())
                        : Image(image: AssetImage(model.getImg())),
                  ),
                  const SizedBox(width: BSizes.sm),
                  Expanded(
                      flex: 5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: Text(model.content,
                                    maxLines: 5,
                                    textAlign: TextAlign.justify,
                                    style: styleContent)),
                            const SizedBox(height: BSizes.sm),
                            TypeTimeNew(
                                type: ItemListController
                                    .instance.newsCategory.value.mapper
                                    .getModelById(model.category)
                                    .name,
                                time: model.formattedDateTime,
                                style: styleDetails)
                          ]))
                ])
              ])));
  }
}
