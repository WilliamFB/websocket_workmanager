import 'dart:developer';

import 'package:background_websocket/background_task_service.dart';
import 'package:background_websocket/websocket_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebsocketService _websocketService;
  final BackgroundTaskService _backgroundTaskService = BackgroundTaskService();

  @override
  void initState() {
    _websocketService = WebsocketService(
      onReceive: onReceive,
      reconnectCallback: reconnectCallback,
    );
    super.initState();
  }

  void onReceive(dynamic message) => log('message: $message');

  void reconnectCallback() => log('trying to reconnect.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _websocketService.init,
              child: const Text('Start websocket'),
            ),
            ElevatedButton(
              onPressed: _websocketService.dispose,
              child: const Text('Stop websocket'),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () => _backgroundTaskService.initialize(),
              child: const Text('Start Background service'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Stop Background service'),
            ),
            ElevatedButton(
              onPressed: () => _backgroundTaskService.registerTask('abc'),
              child: const Text('Register task'),
            ),
          ],
        ),
      ),
    );
  }
}
