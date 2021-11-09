import 'dart:convert';

import '../data.dart';
import 'io.dart';

initSchedule() async {
  print("initSchedule");
  Map _schedule = {};
  for (var i = 1; i < 21; i++) {
    _schedule[i.toString()] = {};
    for (var j = 1; j < 8; j++) {
      _schedule[i.toString()]?[j.toString()] = {};
      for (var k = 1; k < 12; k++) {
        _schedule[i.toString()]?[j.toString()]?[k.toString()] = ["null", "null", "null"];
      }
    }
  }
  schedule = _schedule;
  print("initSchedule End");
  await writeSchedule(jsonEncode(schedule));
}

initTodaySchedule() {
  print("initTodaySchedule");
  final String _week = writeData["week"].toString();
  Map _schedule = schedule;
  List toDay = [];

  _schedule[_week][DateTime.now().weekday.toString()].forEach((k, v) => {
        if (v[1] != "null") {v.add(k), toDay.add(v)}
      });
  if (toDay.isNotEmpty) {
    todayScheduleTitle = "今天的";
    todaySchedule = toDay;
  } else {
    todayScheduleTitle = "今天没课";
  }
  if (writeData["username"] == "") {
    todayScheduleTitle = "";
  }
  print("initTodaySchedule End");
}

initTomorrowSchedule() {
  print("initTomorrowSchedule");
  final String _week = writeData["week"].toString();
  Map _schedule = schedule;
  List tomorrow = [];
  String _getWeekDay() {
    if (DateTime.now().weekday <= 6) {
      return (DateTime.now().weekday + 1).toString();
    } else {
      return "1";
    }
  }

  _schedule[_week][_getWeekDay()].forEach((k, v) => {
        if (v[1] != "null") {v.add(k), tomorrow.add(v)}
      });
  if (tomorrow.isNotEmpty) {
    tomorrowScheduleTitle = "明天的";
    tomorrowSchedule = tomorrow;
  } else {
    tomorrowScheduleTitle = "明天没课嗷";
    if (todayScheduleTitle == "今天没课") tomorrowScheduleTitle = "明天也没课🤣";
  }
  if (writeData["username"] == "") {
    tomorrowScheduleTitle = "";
  }
  print("initTomorrowSchedule End");
}
