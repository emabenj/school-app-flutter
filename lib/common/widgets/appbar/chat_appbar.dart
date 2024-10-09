import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BChatAppBar({
    super.key,
    required this.img,
    required this.widget,
    required this.color,
    required this.online, required this.name,
  });
  final String img;
  final Widget widget;
  final Color color;
  final String name;
  final bool online;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        padding: const EdgeInsets.all(BSizes.sm),
        child: AppBar(
            backgroundColor: color,
            automaticallyImplyLeading: false,
            centerTitle: false,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_left)),
            title: Row(children: [
              Padding(
                  padding: const EdgeInsets.all(BSizes.xs),
                  child: CircleAvatar(backgroundImage: AssetImage(img))),
              Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, overflow: TextOverflow.ellipsis),
                      Text(online ? BTexts.online : BTexts.offline,
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color:
                                  online ? BColors.greenLight : BColors.black))
                    ]),
              )
            ]),
            actions: [widget]));
  }

  @override
  Size get preferredSize => Size.fromHeight(BDeviceUtils.getAppBarHeight());
}
