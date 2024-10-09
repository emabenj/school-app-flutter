import 'package:colegio_bnnm/features/school/models/messages/select/user_item_model.dart';
import 'package:flutter/material.dart';
import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/common/widgets/users/notification_icon.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';

class BAppBarHome extends StatelessWidget {
  const BAppBarHome({super.key, required this.user});

  final UserForHome user;

  @override
  Widget build(BuildContext context) {
    final String nameText = user.getText();
    return BAppBar(
        title: nameText.isEmpty?const SizedBox(): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(BTexts.home,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: Colors.white)),
              Text("${BTexts.homeWelcome}${user.getText()}",
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: Colors.white))
            ]),
        actions: [
          BNotificationIcon(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              iconColor: Colors.white)
        ]);
  }
}
