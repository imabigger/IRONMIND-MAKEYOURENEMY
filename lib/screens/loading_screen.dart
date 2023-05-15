import 'package:flutter/material.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/setting_argument.dart';
import 'package:iron_mind/screens/change_default_time.dart';
import 'package:iron_mind/screens/list_setting.dart';
import 'package:iron_mind/screens/view_winday_screen.dart';

class LoadingScreen extends StatelessWidget {
  final int? argument;
  const LoadingScreen({this.argument,super.key});

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)?.settings.arguments != null)
      {
        if(ModalRoute.of(context)!.settings.arguments ==  firstSetting){
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.of(context).pushNamedAndRemoveUntil('/one', (route) => false);
            /*Navigator.of(context).pushNamed('/one');*/
          });
        } else if(ModalRoute.of(context)!.settings.arguments == listSetting){
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ListSetting()));
          });
        } else if(ModalRoute.of(context)!.settings.arguments == timeSetting){
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ChangeDefaultTime()));
          });
        } else if(ModalRoute.of(context)!.settings.arguments == viewWin){
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ViewWinDayScreen()));
          });
        }
      } else if(argument != null && argument == firstSetting) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.of(context).pushNamedAndRemoveUntil('/one', (route) => false);
        /*Navigator.of(context).pushNamed('/one');*/
      });
    }

    final ts = TextStyle(
      fontSize: 110.0,
      fontWeight: FontWeight.w900,
    );

    return Scaffold(
      backgroundColor: PRIMARYCOLOR,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'IRON',
              style: ts,
            ),
            Text(
              'MIND',
              style: ts,
            ),
            CircularProgressIndicator(strokeWidth: 8),
          ],
        ),
      ),
    );
  }
}
