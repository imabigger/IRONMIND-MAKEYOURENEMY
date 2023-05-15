import 'package:hive_flutter/hive_flutter.dart';
part 'status_model.g.dart';

@HiveType(typeId: 2)
enum TimeInterval {
  @HiveField(1)
  half,
  @HiveField(2)
  hour,
  @HiveField(3)
  nine,
}

@HiveType(typeId: 1)
class StatusModel {
  @HiveField(0)
  List<String> comList;
  @HiveField(1)
  TimeInterval timeInterval;
  @HiveField(2)
  int startTime = 700;
  @HiveField(3)
  int endTime = 2200;
  @HiveField(4)
  int countWin = -1;
  @HiveField(5)
  int countConsecutiveWin = 0;

  StatusModel({required this.comList, required this.timeInterval});
}

@HiveType(typeId: 4)
enum TimeBoxStatus {
  @HiveField(0)
  complete,
  @HiveField(1)
  fail,
  @HiveField(2)
  wait
}

@HiveType(typeId: 3)
class TimeBoxModel {
  @HiveField(0)
  List<TimeBoxStatus> boxList;

  TimeBoxModel({required this.boxList});
}
