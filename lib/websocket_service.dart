import 'dart:developer';

import 'package:web_socket_channel/io.dart';

class WebsocketService {
  late IOWebSocketChannel _channel;
  bool _conectado = true;
  bool _disposed = false;
  void Function() reconnectCallback;
  void Function(dynamic) onReceive;

  WebsocketService({
    required this.onReceive,
    required this.reconnectCallback,
  });

  Future<void> init() async {
    _disposed = false;
    await _connect();
    await _listen();
  }

  Future<void> _connect() async {
    _channel = IOWebSocketChannel.connect(
      'wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self',
      headers: {},
      pingInterval: const Duration(seconds: 5),
    );
  }

  Future<void> dispose() async {
    _disposed = true;
    await _channel.sink.close();
  }

  Future<void> _listen() async {
    _channel.stream.listen(
      (message) {
        // o atributo _conectado é usado para realizar alguma ação após reconexão
        if (!_conectado) {
          _conectado = true;
          reconnectCallback();
        }
        onReceive(message);
      },
      onError: (_) async {
        log('onError');
        _reconnect();
      },
      onDone: () async {
        log('onDone');
        _reconnect();
      },
      cancelOnError: true,
    );
  }

  Future<void> _reconnect() async {
    log('reconnect called');
    // Em caso de desconexão, o app tenta reconectar a cada 5s.
    // Nos casos de dispose o app não tenta fazer reconexão.
    if (_disposed) return;
    _conectado = false;
    await Future.delayed(const Duration(seconds: 5));
    await init();
  }

  void sendMessage(String message) => _channel.sink.add(message);
}
