import 'package:colegio_bnnm/common/styles/spacing_styles.dart';
import 'package:colegio_bnnm/common/widgets/appbar/appbar.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/footer_attendance.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/header_attendance.dart';
import 'package:colegio_bnnm/features/school/screens/attendance/widgets/student_list_attendance.dart';
import 'package:colegio_bnnm/util/constants/colors.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:colegio_bnnm/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: const BAppBar(showBackArrow: true),
        body: SingleChildScrollView(
            padding: BSpacingStyles.paddingWithOutAppBarHeight,
            child: Column(children: [
              //HEADER (time - date)
              const HeaderAttendance(),
              const SizedBox(height: BSizes.spaceBtwItems),
              //LIST
              Divider(color: dark ? BColors.white : BColors.black, height: 2),
              const SizedBox(height: BSizes.sm),
              const StudentListAttendance(),
              Divider(color: dark ? BColors.white : BColors.black, height: 2),
              const SizedBox(height: BSizes.spaceBtwItems),
              //FOOTER (info - button)
              const FooterAttendance()
            ])));
  }
}
