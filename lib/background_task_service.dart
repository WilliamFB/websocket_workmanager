import 'package:workmanager/workmanager.dart';

import 'main.dart';

class BackgroundTaskService {
  Future<void> initialize() async {
    print('Initialize workmanager');
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    print('Workmanager initialized');
  }

  void registerTask(String key) {
    Workmanager().registerOneOffTask(
      key,
      key,
      inputData: <String, dynamic>{
        'int': 1,
        'bool': true,
        'double': 1.0,
        'string': 'string',
        'array': [1, 2, 3],
      },
    );
  }

  void cancelAll() => Workmanager().cancelAll();
}
