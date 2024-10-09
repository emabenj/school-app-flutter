import 'package:colegio_bnnm/features/school/screens/home/widgets/drawer/menu_items_drawer_home.dart';
import 'package:colegio_bnnm/features/school/screens/home/widgets/header_drawer.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer(
      {super.key, required this.name, required this.role, required this.color, required this.img});
  final String name;
  final Roles role;
  final Color color;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
            child: Container(
                color: color,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeaderDrawer(name: name, img: img),
                      MenuItemsDrawerHome(role: role)
                    ]))));
  }
}
