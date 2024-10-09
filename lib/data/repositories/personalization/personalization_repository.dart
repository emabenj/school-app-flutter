import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/data/services/personalization/personalization_service.dart';
import 'package:colegio_bnnm/features/personalization/models/user_update_model.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:colegio_bnnm/util/mappers/authentication_mapper.dart';
import 'package:get/get.dart';

class PersonalizationRepository extends GetxController {
  static String schoolUrl = APIConstants.schoolUrl;

  static PersonalizationRepository get instance => Get.find();
  final _personalization = PersonalizationService();

  Future<String> updateUser(
      String email, String phoneNumber, String address) async {
    final user = AuthenticationRepository.instance.currentUser()!;
    final id = user.user.id;
    final model = UserUpdateModel(
        id: id, email: email, phoneNumber: phoneNumber, address: address);
    final urlUpdate = "${BAuthMapper.urlRole(user.role)}/";
    return await _personalization.updateUser(urlUpdate, id, model);
  }
}
