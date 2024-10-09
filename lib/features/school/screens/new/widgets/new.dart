import 'package:colegio_bnnm/common/widgets/containers/selected_container.dart';
import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/repositories/school/school_repository.dart';
import 'package:colegio_bnnm/features/school/controllers/home/navigation_controller.dart';
import 'package:colegio_bnnm/features/school/controllers/news/news_controller.dart';
import 'package:colegio_bnnm/features/school/models/new/new_model.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/new_information.dart';
import 'package:colegio_bnnm/features/school/screens/new/widgets/edit_delete_buttons.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class NewForHome extends StatefulWidget {
  const NewForHome(
      {super.key,
      required this.model,
      required this.onTapCrudButtons,
      required this.index});
  final NewModel model;
  final int index;
  final void Function() onTapCrudButtons;

  @override
  State<NewForHome> createState() => _NewForHomeState();
}

class _NewForHomeState extends State<NewForHome> {
  final controller = NewsController.instance;
  final navController = NavigationController.instance;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return BSelectedContainer(
        onTap: controller.forA.value
            ? () {
                _isPressed = !_isPressed;
                setState(() {});
              }
            : null,
        onLongPress: () => _showNewExpanded(context, widget.index),
        childExtra: EditDeletNew(
            onTap: () {
              setState(() {
                _isPressed = !_isPressed;

                widget.onTapCrudButtons();
              });
            },
            index: widget.index),
        pressed: _isPressed,
        colorOpacity: Colors.black,
        size: Size(BHelperFunctions.screenWidth(),
            BHelperFunctions.screenHeight() * .21),
        child: NewInfo(model: widget.model));
  }

  Future<void> _showNewExpanded(BuildContext context, int index) async {
    final dark = BHelperFunctions.isDarkMode(context);
    final background = dark ? BColors.black : BColors.white;

    final isAdmin = navController.isAdmin();

    NewModel modelToShow = widget.model;
    await AuthenticationRepository.instance.responseValidatorControllers(() async {
      modelToShow = !isAdmin
          ? await SchoolRepository.instance.getNewById(widget.model)
          : modelToShow;
    }, titleMessage: "Error al cargar la noticia");
    setState(() {
      controller.news[index].views = modelToShow.views;
    });
    showModalBottomSheet(
        backgroundColor: background,
        // ignore: use_build_context_synchronously
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return NewInfo(model: modelToShow, state: NewsState.expanded);
        });
  }
}
