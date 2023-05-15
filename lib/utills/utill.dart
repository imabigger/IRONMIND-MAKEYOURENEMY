import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/rank.dart';
import 'package:iron_mind/model/status_model.dart';

class DataUtil {

  static CountWinDay getCountWinDayFromModelCount({required int modelCount}){
    if(modelCount == 0){
      return CountWinDay.zero;
    }else if(modelCount == 1){
      return CountWinDay.one;
    }else if(modelCount < 4){
      return CountWinDay.two;
    }else if(modelCount < 7){
      return CountWinDay.four;
    }else if(modelCount < 15){
      return CountWinDay.seven;
    }else if(modelCount < 30){
      return CountWinDay.fifteen;
    }else if(modelCount < 90){
      return CountWinDay.thirty;
    }else{
      return CountWinDay.threeMonth;
    }
  }

  static int getDayCountFromCountWinDay({required CountWinDay countWinDay}){
    switch(countWinDay){

      case CountWinDay.one:
        // TODO: Handle this case.
        return 1;
      case CountWinDay.two:
        // TODO: Handle this case.
        return 2;
      case CountWinDay.four:
        // TODO: Handle this case.
        return 4;
      case CountWinDay.seven:
        // TODO: Handle this case.
        return 7;
      case CountWinDay.fifteen:
        // TODO: Handle this case.
        return 15;
      case CountWinDay.thirty:
        // TODO: Handle this case.
        return 30;
      case CountWinDay.threeMonth:
        // TODO: Handle this case.
        return 90;
      case CountWinDay.zero:
        // TODO: Handle this case.
        return 0;
    }
  }

  static String showRankNumberOfTimeFromWinCount({required CountWinDay countWinDay}){
    switch (countWinDay) {
      case CountWinDay.one:
        // TODO: Handle this case.
        return RankNumberOfTimes.rookie.name;
      case CountWinDay.two:
        // TODO: Handle this case.
        return RankNumberOfTimes.beginner.name;
      case CountWinDay.four:
        // TODO: Handle this case.
        return RankNumberOfTimes.intermediate.name;
      case CountWinDay.seven:
        // TODO: Handle this case.
        return RankNumberOfTimes.skilled.name;
      case CountWinDay.fifteen:
        // TODO: Handle this case.
        return RankNumberOfTimes.expert.name;
      case CountWinDay.thirty:
        // TODO: Handle this case.
        return RankNumberOfTimes.master.name;
      case CountWinDay.threeMonth:
        // TODO: Handle this case.
        return RankNumberOfTimes.legend.name;
      case CountWinDay.zero:
        // TODO: Handle this case.
        return RankNumberOfTimes.Mind.name;
    }
  }

  static String showRankConsecutiveTimeFromWinCount({required CountWinDay countWinDay}){
    switch(countWinDay){

      case CountWinDay.one:
        // TODO: Handle this case.
        return RankConsecutiveTimes.novice.name;
      case CountWinDay.two:
        // TODO: Handle this case.
        return RankConsecutiveTimes.steady.name;
      case CountWinDay.four:
        // TODO: Handle this case.
        return RankConsecutiveTimes.streaker.name;
      case CountWinDay.seven:
        // TODO: Handle this case.
        return RankConsecutiveTimes.persistent.name;
      case CountWinDay.fifteen:
        // TODO: Handle this case.
        return RankConsecutiveTimes.unstoppable.name;
      case CountWinDay.thirty:
        // TODO: Handle this case.
        return RankConsecutiveTimes.invincible.name;
      case CountWinDay.threeMonth:
        // TODO: Handle this case.
        return RankConsecutiveTimes.ultimate.name;
      case CountWinDay.zero:
        // TODO: Handle this case.
        return RankConsecutiveTimes.Iron.name;
    }
  }

  static int getIntTimeFromTimeInterval({required TimeInterval timeInterval}) {
    switch (timeInterval) {
      case TimeInterval.hour:
        return 60;
      case TimeInterval.half:
        return 30;
      case TimeInterval.nine:
        return 90;
    }
  }

  static int getTotalTimeListCountFromModelStartEndTimeAndTimeInterval({
    required TimeInterval timeInterval,
    required int mstartTime,
    required int mendTime,
}){//model starttime endtime 은 30분단위로 바뀜 => 60,90이면 나눠지지 않을 수 있음
    int start = getMinTimeFromModelTime(mTime: mstartTime);
    int end = getMinTimeFromModelTime(mTime: mendTime);
    int interval = getIntTimeFromTimeInterval(timeInterval: timeInterval);
    int total = (end-start)~/interval;

    if(timeInterval == TimeInterval.half){
      return total;
    }else{
      if((end-start)%interval > 0){
        return total +1;
      }
      return total;
    }
  }

  static TimeBoxModel setTimeBoxModelWithSETimeAndTimeInterval({required int mStartTime, required int mEndTime, required TimeInterval timeInterval}){
    return TimeBoxModel(
        boxList: List.generate(
            DataUtil
                .getTotalTimeListCountFromModelStartEndTimeAndTimeInterval(
              timeInterval: timeInterval,
              mstartTime: mStartTime,
              mendTime: mEndTime,
            ),
                (index) => TimeBoxStatus.wait));
  }

  static String getStringHourMinTimeFromMin({required int time}){
    int hour = time~/60;
    int min = time%60;
    return '$hour : ${min.toString().padRight(2,'0')}';
  }
  static String getStringHourMinPADLEFTTimeFromMin({required int time}){
    int hour = time~/60;
    int min = time%60;
    return '${hour.toString().padLeft(2,'0')} : ${min.toString().padRight(2,'0')}';
  }

  static int getMinTimeFromModelTime({required int mTime}){
    return (mTime~/100)*60 + (mTime%100)%60;
  }

  static int checkModelTimeIfToModelTime({required int mTime}){
    if(mTime % 100 == 60){
      return (mTime~/100)*100 + 100;
    }else if(mTime % 100 == 70){
      return (mTime~/100)*100 + 30;
    }
    else {
      return mTime;
    }
  }

  static void changeTimeModelsTimeStatusInIndex({required int index, required TimeBoxStatus timeBoxStatus}) {
    final timeBox = Hive.box<TimeBoxModel>(userTime);
    final key = timeBox.keys.last;
    final value = timeBox.values.last;
    value.boxList[index] = timeBoxStatus;

    timeBox.deleteAt(0);
    timeBox.put(key, value);
  }

  static int getWinTimeFromCurrentTimeBox({required TimeBoxModel timeBoxModel}){
    return (timeBoxModel.boxList.where((timeBoxStatus) => timeBoxStatus == TimeBoxStatus.complete)).length;
  }

  static int getWinRatio({required int totalLength, required int currentWin}){
    return (100*currentWin~/totalLength);
  }

}
