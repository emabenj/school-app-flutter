import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/text_strings.dart';

class BAuthMapper {
  static const _roles = BTexts.roleList;

  static Roles role(String roleName) {
    if (_roles.contains(roleName)) {
      return Roles.values[_roles.indexOf(roleName)];
    }
    return Roles.values.byName(roleName);
  }

  static String urlRole(Roles role, {bool inSingular = false}) {
    return "${_roles[Roles.values.indexOf(role)].toLowerCase()}${inSingular ? "" : "s"}";
  }
}
