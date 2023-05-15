import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/text_style.dart';
import 'package:iron_mind/layout/setting_lay_out.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/utills/utill.dart';

class ViewWinDayScreen extends StatelessWidget {
  final box = Hive.box<StatusModel>(userBox);
  ViewWinDayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consecWinDay = box.values.last.countConsecutiveWin;
    final totalWinDay = box.values.last.countWin;
    print(consecWinDay);

    return SettingLayOut(
      topText: '',
      body: Column(
        children: [
          Text(
            'Consecutive',
            style: MAIN_TEXT,
          ),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000.0),
                border: Border.all(
                  width: 0.5,
                  color: Colors.redAccent,
                )),
            child: Center(
              child: Text(
                getWinDayContainsZero(consecWinDay),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50 + log((consecWinDay+1) * 3.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          Text(
            'Total',
            style: MAIN_TEXT.copyWith(fontSize: 16.0),
          ),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000.0),
                border: Border.all(
                  width: 0.5,
                  color: Colors.blueAccent,
                )),
            child: Center(
              child: Text(
                getWinDayContainsZero(totalWinDay),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25 + log((totalWinDay+1) * 3.0),
                ),
              ),
            ),
          ),
        ],
      ),
      buttonText: 'Back',
      onPressedBottomButton: () {
        Navigator.of(context).pop();
      },
    );
  }


  String getWinDayContainsZero(int day){
    if(day == 0) return '0';
    return day.toString();
  }
}
