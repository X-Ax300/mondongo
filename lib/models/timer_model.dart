import 'package:hive/hive.dart';

part 'timer_model.g.dart';

@HiveType(typeId: 0)
class TimerModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  int hours;

  @HiveField(2)
  int minutes;

  @HiveField(3)
  int seconds;

  @HiveField(4)
  DateTime endTime;

  TimerModel({
    required this.title,
    required this.hours,
    required this.minutes,
    required this.seconds,
  }) : endTime = DateTime.now().add(Duration(hours: hours, minutes: minutes, seconds: seconds));
}
