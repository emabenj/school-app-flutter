import 'package:flutter/material.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';

class BNotificationIcon extends StatelessWidget {
  const BNotificationIcon(
      {super.key, required this.onPressed, required this.iconColor});

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.notifications, color: iconColor)),
        Positioned(
          right: 5,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: BColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text("16",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: Colors.white, fontSizeFactor: .8)),
            ),
          ),
        )
      ],
    );
  }
}