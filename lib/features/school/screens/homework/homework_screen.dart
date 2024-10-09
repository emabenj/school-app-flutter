import 'package:colegio_bnnm/common/widgets/scaffold/two_containers_scaffold.dart';
import 'package:colegio_bnnm/features/school/screens/homework/widgets/homework_container.dart';
import 'package:colegio_bnnm/features/school/screens/homework/widgets/previous_homework_container.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = ForScaffoldModel(
        BTexts.homeworkTitle,
        BTexts.homeworkPrevious,
        const HomeworkContainer(),
        const PreviousHomeworkContainer(),
        BColors.greenDark,
        BHelperFunctions.isDarkMode(context)
                          ? BColors.black
                          : BColors.grey);
    return TwoContainerScaffold(modelScaffold: scaffold);
  }
}
