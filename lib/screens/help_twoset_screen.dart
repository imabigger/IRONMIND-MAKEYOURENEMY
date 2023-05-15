import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/component/sub_text.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/text_style.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/utills/utill.dart';

class HelpTwoSetScreen extends StatelessWidget {
  final box = Hive.box<StatusModel>(userBox);

  HelpTwoSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARYCOLOR,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  TextHelpTwo(),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: TimeInterval.values
                        .map((time) => renderTimeIntervalButton(context,time))
                        .toList(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, right: 8.0),
                    width: MediaQuery.of(context).size.width,
                    child: SubText(
                        content: 'It can be changed later\n at any time.'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlinedButton renderTimeIntervalButton(BuildContext context,TimeInterval timeInterval) =>
      OutlinedButton(
        onPressed: () async{
          //선택된 분 저장하고
          final String key = box.keys.last;
          final StatusModel status = box.values.last;
          status.timeInterval = timeInterval;
          await box.deleteAt(0);
          await box.put(key, status);

          Future.delayed(Duration(seconds: 0)).then((value) {
            Navigator.of(context).pushNamed('/three');
          });
        },
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(Colors.redAccent.withOpacity(0.3)),
        ),
        child: Text(
          '${DataUtil.getIntTimeFromTimeInterval(timeInterval: timeInterval).toString()} min',
          style: const TextStyle(
            color: IRONCOLOR,
          ),
        ),
      );
}

class TextHelpTwo extends StatelessWidget {
  const TextHelpTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Now,\nyou need \nto set a time interval.\n\n'
      'With this time interval,\nyou will record\n'
      'whether you have won or lost\nagainst your enemies in battles.',
      style: MAIN_TEXT,
    );
  }
}
