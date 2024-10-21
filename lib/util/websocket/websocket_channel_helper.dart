import 'package:colegio_bnnm/data/repositories/authentication/authentication_repository.dart';
import 'package:colegio_bnnm/util/constants/api_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BWebSocketHelper {
  static const _baseUrl = "ws://${APIConstants.domain}";

  static WebSocketChannel _connectChannel(
      String endpoint,  String token) {
    final authentication = token.isNotEmpty ? "?token=$token" : "";
    final channel = WebSocketChannel.connect(
      Uri.parse('$_baseUrl$endpoint$authentication'),
    );
    return channel;
  }

  static List<WebSocketChannel> connectChannels(
      List<String> endpoints, List<void Function(dynamic)?> onDatas) {
    assert(endpoints.length == onDatas.length,
        'La cantidad de endpoints y funciones deben ser iguales.');
    //
    final token = AuthenticationRepository.instance.token();

    final channels = <WebSocketChannel>[];
    for (var i = 0; i < endpoints.length; i++) {
      final channel = _connectChannel(endpoints[i], token);
      channels.add(channel);
    }
    return channels;
  }

  static void disconnectChannels(List<WebSocketChannel> channelList) {
    if (channelList.isNotEmpty) {
      for (var c in channelList) {
        c.sink.close();
      }
      channelList.clear();
    }
  }
}
