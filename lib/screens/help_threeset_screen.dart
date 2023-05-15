import 'package:flutter/material.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/rank.dart';
import 'package:iron_mind/const/text_style.dart';
import 'package:iron_mind/layout/setting_lay_out_two.dart';
import 'package:iron_mind/utills/utill.dart';

class HelpThreeSetScreen extends StatelessWidget {
  const HelpThreeSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
        color: IRONCOLOR,
        fontFamily: 'mynerve',
        fontWeight: FontWeight.w700,
        fontSize: 32.0);

    return SettingLayOutTwo(
      topText: 'MIND',
      buttonText: 'understand',
      backgroundcolor: PRIMARYCOLOR,
      onPressedBottomButton: () {
        Navigator.of(context).pushNamed('/four');
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextHelpThree(),
            Text(
              'RANK',
              style: TextStyle(fontSize: 32.0, color: IRONCOLOR),
            ),
            Text('━━━━━━━━━━━━━━━━━', style: MAIN_TEXT),
            SizedBox(height: 16.0),
            Text(
              'Number of times',
              style: ts,
            ),
            SizedBox(height: 16.0),
            ...CountWinDay.values.map(
              (countWinDay) {
                return Row(
                  children: [
                    Text(
                      '${DataUtil.getDayCountFromCountWinDay(countWinDay: countWinDay).toString().padRight(2, ' ')} Day Win: ',
                      style: ts.copyWith(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    ),
                    Text('\t' * 3),
                    Text(
                      DataUtil.showRankNumberOfTimeFromWinCount(
                          countWinDay: countWinDay),
                      style: MAIN_TEXT.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )
                  ],
                );
              },
            ).toList(),
            SizedBox(height: 32.0),
            Text(
              'Consecutive times',
              style: ts,
            ),
            SizedBox(height: 16.0),
            ...CountWinDay.values.map(
                  (countWinDay) {
                return Row(
                  children: [
                    Text(
                      '${DataUtil.getDayCountFromCountWinDay(countWinDay: countWinDay).toString().padRight(2, ' ')} Day Win: ',
                      style: ts.copyWith(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    ),
                    Text('\t' * 3),
                    Text(
                      DataUtil.showRankConsecutiveTimeFromWinCount(
                          countWinDay: countWinDay),
                      style: MAIN_TEXT.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )
                  ],
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}

class TextHelpThree extends StatelessWidget {
  const TextHelpThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'If you win in competition with your alter ego at a rate of 60% to 80%, you will receive a rank. '
      '\n\nDon\'t give up and persevere. '
      '\n\nDon\'t enslave yourself anymore. '
      '\n\nThis is also God\'s command,and it is what pleases God. '
      '\n\nLet\'s conquer the world given to your life.'
      '\n\n━━━━━━━━━━━━━━━━━',
      style: MAIN_TEXT,
    );
  }
}
