import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketModel {
  final String endpoint;
  final WebSocketChannel channel;

  WebSocketModel(this.endpoint, this.channel);
}