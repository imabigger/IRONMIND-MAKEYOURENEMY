import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/component/bottom_sheet.dart';
import 'package:iron_mind/component/check_list.dart';
import 'package:iron_mind/component/main_drawer.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/setting_argument.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/screens/loading_screen.dart';
import 'package:iron_mind/utills/utill.dart';
import 'package:flutter/services.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final box = Hive.box<StatusModel>(userBox);
  final timeBox = Hive.box<TimeBoxModel>(userTime);
  final date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<bool> _boxHasData() async {
    return box.isEmpty ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));

    return FutureBuilder<bool>(
        future: _boxHasData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const LoadingScreen();
          }

          if (!snapshot.data!) {
            box.put(
              date.toString(),
              StatusModel(comList: [], timeInterval: TimeInterval.hour),
            );
            return const LoadingScreen(argument: firstSetting);
          } else {
            final String key = box.keys.last; // 1개만 들어 있음 어차피
            final StatusModel status = box.values.last;
            final TimeBoxModel currentTimeBox = timeBox.values.last;
            DateTime dataDate = DateTime.parse(key);

            if (status.comList.isEmpty || status.countWin == -1) {
              return const LoadingScreen(argument: firstSetting);
            } else if (!date.isAtSameMomentAs(dataDate)) {
              // 진행 상황 체크후 count 증가 필요
              int currentWinCount = DataUtil.getWinTimeFromCurrentTimeBox(
                  timeBoxModel: currentTimeBox);

              if (DataUtil.getWinRatio(
                      totalLength: currentTimeBox.boxList.length,
                      currentWin: currentWinCount) >=
                  60) {

                status.countWin += 1;
                status.countConsecutiveWin += 1;
                box.put(date.toString(), status);
                box.deleteAt(0);

              } else {

                status.countConsecutiveWin = 0;
                box.put(date.toString(), status);
                box.deleteAt(0);

              }


              for (int i = 0; i < currentTimeBox.boxList.length; i++) {
                currentTimeBox.boxList[i] = TimeBoxStatus.wait;
              }
              timeBox.put(date.toString(), currentTimeBox);
              timeBox.deleteAt(0);
            }
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: PRIMARYCOLOR,
              centerTitle: true,
              title: Text('IRON MIND', style: TextStyle(
                fontFamily: 'mynerve',
                color: IRONCOLOR,
                  fontWeight: FontWeight.w900,
                fontSize: 30.0
              ),),
            ),
            backgroundColor: PRIMARYCOLOR,
            drawer: const MainDrawer(),
            body: Column(
              children: [
                Expanded(
                  flex: 12,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(), // later update
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          color: DARKCOLOR.withOpacity(0.5),
                          child: CheckList(
                            oldSetState: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: DARKCOLOR,
                    child: CustomBottomSheet(),
                  ),
                )
              ],
            ),
          );
        });
  }
}
