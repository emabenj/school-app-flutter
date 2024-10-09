import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:colegio_bnnm/util/http/http_client.dart';
import 'package:colegio_bnnm/util/http/message_model.dart';

class PersonalizationService {
  static String schoolUrl = APIConstants.schoolUrl;
  final authRepository = AuthenticationRepository.instance;

  Future<dynamic> updateUser(String url, int id, dynamic model) async {
    return await authRepository.responseValidatorServices(() async {
      // TOKEN
      final token = authRepository.token();
      final urlEdit = "$schoolUrl$url$id/";
      final response = await BHttpHelper.patch(urlEdit, model, token: token);
      if (response.containsKey('message')) {
        final message = MessageResponseModel.fromJson(response).message;
        return message;
      } else {}
    });
  }
}
