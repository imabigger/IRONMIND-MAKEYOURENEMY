import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/adhelper/ad_helper.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/layout/setting_lay_out_two.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/utills/utill.dart';

class ChangeDefaultTime extends StatefulWidget {
  const ChangeDefaultTime({Key? key}) : super(key: key);

  @override
  State<ChangeDefaultTime> createState() => _ChangeDefaultTimeState();
}

class _ChangeDefaultTimeState extends State<ChangeDefaultTime> {
  final box = Hive.box<StatusModel>(userBox);
  final timeBox = Hive.box<TimeBoxModel>(userTime);
  late int startTime;
  late int endTime;

  BannerAd? _bannerAd;

  @override
  void initState() {
    // TODO: implement initState
    startTime = box.values.last.startTime;
    endTime = box.values.last.endTime;

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SettingLayOutTwo(
      floatingActionButton: renderBackFloatingActionButton(context),
      topText: 'Setting Time',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '* caution *\n'
              ' your main check will pop',
              style: TextStyle(
                  fontFamily: 'oswald',
                  color: DARKCOLOR.withOpacity(0.7),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 45.0),
            ChangeTime(
              onpressedUp: () {
                setState(() {
                  if (startTime <
                      DataUtil.checkModelTimeIfToModelTime(
                          mTime: endTime - 30)) {
                    startTime += 30;
                    startTime =
                        DataUtil.checkModelTimeIfToModelTime(mTime: startTime);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('no more')));
                  }
                });
              },
              onpressedDown: () {
                setState(() {
                  if (startTime >= 30) {
                    startTime -= 30;
                    startTime =
                        DataUtil.checkModelTimeIfToModelTime(mTime: startTime);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('no more')));
                  }
                });
              },
              name: 'Start Time',
              time: startTime,
            ),
            const SizedBox(height: 30.0),
            ChangeTime(
              onpressedUp: () {
                setState(() {
                  if (endTime <= 2330) {
                    endTime += 30;
                    endTime =
                        DataUtil.checkModelTimeIfToModelTime(mTime: endTime);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('no more')));
                  }
                });
              },
              onpressedDown: () {
                setState(() {
                  if (endTime >
                      DataUtil.checkModelTimeIfToModelTime(
                          mTime: startTime + 30)) {
                    endTime -= 30;
                    endTime =
                        DataUtil.checkModelTimeIfToModelTime(mTime: endTime);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('no more')));
                  }
                });
              },
              name: 'End Time',
              time: endTime,
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: TimeInterval.values
                  .map((time) => renderTimeIntervalButton(context,time))
                  .toList(),
            ),
          const Text(
            'If you want change time interval, Click on one of the 3',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'oswald',
              color: IRONCOLOR,
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
            if (_bannerAd != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
          ],
        ),
      ),
      buttonText: 'save',
      onPressedBottomButton: onSavePressed,
    );
  }

  void onSavePressed() {
    final status = box.values.last;
    final key = box.keys.last;
    final TimeBoxModel tBox = DataUtil.setTimeBoxModelWithSETimeAndTimeInterval(mStartTime: startTime, mEndTime: endTime, timeInterval: status.timeInterval);
    status.startTime = startTime;
    status.endTime = endTime;

    box.deleteAt(0);
    box.put(key, status);
    timeBox.deleteAt(0);
    timeBox.put(key, tBox);

    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  FloatingActionButton renderBackFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: '예시 다시 보러가기',
      mini: true,
      backgroundColor: IRONCOLOR.withOpacity(0.05),
      elevation: 0,
      child: const Icon(
        Icons.arrow_back_outlined,
        color: DARKCOLOR,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
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
        },
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor:
          MaterialStateProperty.all(Colors.white30),
          side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.grey[400]!,width: 2.0))
        ),
        child: Text(
          '${DataUtil.getIntTimeFromTimeInterval(timeInterval: timeInterval).toString()} min',
          style: const TextStyle(
            color: IRONCOLOR,
          ),
        ),
      );


  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }
}

class ChangeTime extends StatelessWidget {
  final String name;
  final int time;
  final VoidCallback onpressedUp;
  final VoidCallback onpressedDown;
  const ChangeTime(
      {required this.onpressedUp,
      required this.onpressedDown,
      Key? key,
      required this.name,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30.0),
        Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.4 - 16.0),
          child: Text(
            name,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15.0),
        Row(
          children: [
            Expanded(
                flex: 6,
                child: Text(
                  DataUtil.getStringHourMinPADLEFTTimeFromMin(
                    time: DataUtil.getMinTimeFromModelTime(mTime: time),
                  ),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontFamily: 'oswald',
                  ),
                  textAlign: TextAlign.center,
                )),
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: onpressedUp,
                icon: const Icon(Icons.arrow_upward, size: 32.0),
                color: DARKCOLOR,
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: onpressedDown,
                icon: const Icon(Icons.arrow_downward, size: 32.0),
                color: DARKCOLOR,
              ),
            ),
          ],
        )
      ],
    );
  }
}
