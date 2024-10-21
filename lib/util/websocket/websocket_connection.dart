import 'package:colegio_bnnm/util/websocket/websocket_channel_helper.dart';
import 'package:colegio_bnnm/util/websocket/websocket_model.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BWebSocketConnection {
  final List<WebSocketModel> _connections = [];

  void createNewConnections(
      List<String> endpoints, List<void Function(dynamic)?> onDatas) {
    final validatedEndpoints = validateEndpoints(endpoints);
    final validatedOnDatas =
        validateOnDatas(validatedEndpoints, endpoints, onDatas);
    final channels =
        BWebSocketHelper.connectChannels(validatedEndpoints, validatedOnDatas);
    for (var i = 0; i < validatedEndpoints.length; i++) {
      if (validatedEndpoints.contains(endpoints[i])) {
        // Guardar el canal en la lista
        _addChannel(validatedEndpoints[i], channels[i]);
      }
      // Escuchar eventos de la conexión
      channels[i].stream.listen(
        onDatas[i],
        onError: (error) {
          // print("Error: $error");
        },
        onDone: () {
          // print("Conexión cerrada");
        },
      );
    }
  }

  void _addChannel(String endpoint, WebSocketChannel channel) {
    _connections.add(WebSocketModel(endpoint, channel));
  }

  // Función para buscar un canal en la lista por el endpoint
  WebSocketChannel? _findChannelByEndpoint(String endpoint) {
    final channel = _connections
        .firstWhereOrNull((element) => element.endpoint == endpoint);
    return channel?.channel;
  }

  void _sendMessageToEndpoint(String endpoint, String message) {
    final channel = _findChannelByEndpoint(endpoint);

    if (channel != null) {
      // Enviar mensaje a través del WebSocketChannel encontrado
      channel.sink.add(message);
      // print("Mensaje enviado a $endpoint: $message");
    } else {
      // print("No se encontró una conexión con el endpoint: $endpoint");
    }
  }

  void sendMessages(List<String> endpoints, List<String> messages) {
    assert(endpoints.length == messages.length,
        'Los endpoints y mensajes deben tener la misma longitud');
    for (var i = 0; i < endpoints.length; i++) {
      final endpoint = endpoints[i];
      final message = messages[i];
      _sendMessageToEndpoint(endpoint, message);
    }
  }

  List<String> validateEndpoints(List<String> endpoints) {
    final connectedEndpoints = _connections.map((e) => e.endpoint).toList();
    final validatedEndpoints =
        endpoints.where((e) => !connectedEndpoints.contains(e)).toList();
    return validatedEndpoints;
  }

  List<void Function(dynamic)?> validateOnDatas(List<String> validatedEndpoints,
      List<String> endpoints, List<void Function(dynamic)?> onDatas) {
    final indexEndpoints =
        validatedEndpoints.map((e) => endpoints.indexOf(e)).toList();
    final validatedOnDatas = onDatas
        .where((od) => indexEndpoints.contains(onDatas.indexOf(od)))
        .toList();
    return validatedOnDatas;
  }

  void disconnectChannels() {
    final channelList = _connections.map((e) => e.channel).toList();
    BWebSocketHelper.disconnectChannels(channelList);
  }
}
