import 'package:colegio_bnnm/features/school/models/messages/select/authorised_item_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/student_item_model.dart';
import 'package:colegio_bnnm/features/school/models/messages/select/teacher_item_model.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/authorised_item.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/parents_student_item.dart';
import 'package:colegio_bnnm/features/school/screens/messages/select/widgets/teacher_item.dart';
import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.status, required this.model, required this.onTap, this.pressed});
  final MessagesStatus status;
  final dynamic model;
  final void Function() onTap;
  final bool? pressed;

  @override
  Widget build(BuildContext context) {
    if (status == MessagesStatus.sending) {
      final parentsStudent = model as StudentItemModel;
      return ParentsStudentItem(model: parentsStudent, onTap: onTap,  pressed: pressed!);
    } else if (status == MessagesStatus.teachersList) {
      final teacher = model as TeacherItemModel;
      return TeacherItem(model: teacher, onTap: onTap);
    } else {
      final authorised = model as AuthorisedItemModel;
      return AuthorisedItem(model: authorised, onTap: onTap);
    }
  }
}
