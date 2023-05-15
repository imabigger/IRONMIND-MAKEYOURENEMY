import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/rank.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/utills/utill.dart';

class CustomBottomSheet extends StatelessWidget {
  final box = Hive.box<StatusModel>(userBox);
  final timeBox = Hive.box<TimeBoxModel>(userTime);

  CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: IRONCOLOR,
      fontWeight: FontWeight.w600,
      fontFamily: 'mynerve',
      fontSize: 30.0,
    );

    final StatusModel status = box.values.last;
    final TimeBoxModel currentTimeBox = timeBox.values.last;
    final CountWinDay countWinDay =
        DataUtil.getCountWinDayFromModelCount(modelCount: status.countWin);
    final CountWinDay countConsecutiveWinDay = DataUtil.getCountWinDayFromModelCount(modelCount: status.countConsecutiveWin);
    final currentWinCount =
        DataUtil.getWinTimeFromCurrentTimeBox(timeBoxModel: currentTimeBox);

    return Row(
      children: [
        Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    DataUtil.showRankConsecutiveTimeFromWinCount(
                        countWinDay: countConsecutiveWinDay),
                    style: ts,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    DataUtil.showRankNumberOfTimeFromWinCount(
                        countWinDay: countWinDay),
                    style: ts.copyWith(fontSize: 20.0, color: Colors.white60),
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              SizedBox(height: 8.0),
              Text(
                'W / F',
                style: TextStyle(
                    fontFamily: 'oswald',
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0),
              ),
              Text(
                '$currentWinCount : ${currentTimeBox.boxList.length - currentWinCount}',
                style: TextStyle(
                    fontFamily: 'oswald',
                    fontWeight: FontWeight.w400,
                    fontSize: 25.0),
              )
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '${DataUtil.getWinRatio(totalLength: currentTimeBox.boxList.length, currentWin: currentWinCount).toString().padLeft(2,'0')}%',
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
