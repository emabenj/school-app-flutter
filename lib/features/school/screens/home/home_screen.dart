import 'package:colegio_bnnm/common/widgets/containers/primary_header_container.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/select/select_controller.dart';
import 'package:colegio_bnnm/features/school/screens/home/widgets/drawer/drawer_home.dart';
import 'package:colegio_bnnm/features/school/screens/home/widgets/home_appbar.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/news_board.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final controller = NavigationController.instance;

  @override
  void initState() {
    super.initState();
    // Registrar el observador de WidgetsBinding
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Eliminar el observador cuando ya no se necesite
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: HomeDrawer(
            color: controller.getColorRole(),
            name: controller.getUser().getName(),
            img: controller.getUser().getRoleImg(),
            role: controller.getRole()),
        body: SingleChildScrollView(
            child: Column(children: [
          BPrimaryHeaderContainer(
              color: controller.getColorRole(),
              widget:
                  Column(children: [BAppBarHome(user: controller.getUser())])),
          const NewsBoardHome()
        ])));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller.teacherOrAuthorised()) {
      final selectController = SelectController.instance;
      if (state == AppLifecycleState.paused) {
        selectController.onlineUsersController.disconnectSockets();
      } else if (state == AppLifecycleState.resumed) {
        selectController.onlineUsersController.connectSockets();
      }
    }
  }
}
