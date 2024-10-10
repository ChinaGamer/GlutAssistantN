import 'package:workmanager/workmanager.dart';

import 'homeWidget.dart';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("执行任务: $task");
    // 在这里处理你的后台任务逻辑
    try {
      await backstageRefresh();
    } catch (err) {
      print('callbackDispatcher: ' + err.toString());
      throw Exception(err);
    }
    // 返回 true 代表任务成功，false 代表任务失败
    return Future.value(true);
  });
}
