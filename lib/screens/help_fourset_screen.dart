import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/text_style.dart';
import 'package:iron_mind/layout/setting_lay_out_two.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/utills/utill.dart';

class HelpFourSetScreen extends StatelessWidget {
  const HelpFourSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<StatusModel>(userBox);
    final timeBox = Hive.box<TimeBoxModel>(userTime);

    return SettingLayOutTwo(
      topText: 'final plea',
      body: const SingleChildScrollView(child: TextHelpFour()),
      buttonText: 'Go',
      onPressedBottomButton: () async {
        final String key = box.keys.last;
        final StatusModel status = box.values.last;
        if (status.countWin == -1) status.countWin++;
        await box.deleteAt(0);
        await box.put(key, status);

        final TimeBoxModel tBox =
            DataUtil.setTimeBoxModelWithSETimeAndTimeInterval(
                mStartTime: status.startTime,
                mEndTime: status.endTime,
                timeInterval: status.timeInterval);

        if (timeBox.isNotEmpty) await timeBox.deleteAt(0);
        await timeBox.put(key, tBox);

        Future.delayed(Duration(seconds: 0)).then((value) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        });
      },
      backgroundcolor: PRIMARYCOLOR,
    );
  }
}

class TextHelpFour extends StatelessWidget {
  const TextHelpFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'And finally,\n'
      'I urge you to never give up '
      'and always strive to be the best version of yourself.'
      '\n\nRemember, the greatest conquest is the one you achieve over yourself.'
      '\n\nKeep pushing forward and never stop learning and growing.'
      '\n\nBest of luck to you!',
      style: MAIN_TEXT,
    );
  }
}
