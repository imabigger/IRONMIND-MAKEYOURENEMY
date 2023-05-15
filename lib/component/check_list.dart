import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/utills/utill.dart';

typedef OldSetState = void Function();

class CheckList extends StatefulWidget {
  final OldSetState oldSetState;
  const CheckList({required this.oldSetState,Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final box = Hive.box<StatusModel>(userBox);
  final timeBox = Hive.box<TimeBoxModel>(userTime);

  late final int totalListCount;
  late final int stTime;
  late final int edTime;
  late final int timeInterval;

  @override
  void initState() {
    // TODO: implement initState
    final status = box.values.last;

    totalListCount =
        DataUtil.getTotalTimeListCountFromModelStartEndTimeAndTimeInterval(
      timeInterval: status.timeInterval,
      mstartTime: status.startTime,
      mendTime: status.endTime,
    );

    stTime = DataUtil.getMinTimeFromModelTime(mTime: status.startTime);

    edTime = DataUtil.getMinTimeFromModelTime(mTime: status.endTime);

    timeInterval =
        DataUtil.getIntTimeFromTimeInterval(timeInterval: status.timeInterval);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTimeBox = timeBox.values.last;
    return ListView.separated(
      itemCount: totalListCount,
      itemBuilder: (_, index) {
        TimeBoxStatus timeBoxStatus = currentTimeBox.boxList[index];

        if (index == 0) {
          return RenderTimeButton(
            stTime: stTime,
            edTime: stTime + (index + 1) * timeInterval,
            onPressed: timeBoxPressed(index),
            timeBoxStatus: timeBoxStatus,
          );
        } else if (index == totalListCount - 1) {
          return RenderTimeButton(
            stTime: stTime + (index) * timeInterval,
            edTime: edTime,
            onPressed: timeBoxPressed(index),
            timeBoxStatus: timeBoxStatus,
          );
        } else {
          return RenderTimeButton(
            stTime: stTime + (index) * timeInterval,
            edTime: stTime + (index + 1) * timeInterval,
            onPressed: timeBoxPressed(index),
            timeBoxStatus: timeBoxStatus,
          );
        }
      },
      separatorBuilder: (_, index) {
        return SizedBox(height: 10.0);
      },
    );
  }

  VoidCallback timeBoxPressed(int index) {
    return () {
      widget.oldSetState();
      final currentTimeBox = timeBox.values.last;
      setState(() {
        if(currentTimeBox.boxList[index] == TimeBoxStatus.complete)
          {
            DataUtil.changeTimeModelsTimeStatusInIndex(
              index: index,
              timeBoxStatus: TimeBoxStatus.fail,
            );
          }
        else if(currentTimeBox.boxList[index] == TimeBoxStatus.wait){
          DataUtil.changeTimeModelsTimeStatusInIndex(
            index: index,
            timeBoxStatus: TimeBoxStatus.complete,
          );
        }
        else{
          DataUtil.changeTimeModelsTimeStatusInIndex(
            index: index,
            timeBoxStatus: TimeBoxStatus.wait,
          );
        }
      });
    };
  }
}

class RenderTimeButton extends StatelessWidget {
  final int stTime;
  final int edTime;
  final VoidCallback? onPressed;
  final TimeBoxStatus timeBoxStatus;

  const RenderTimeButton(
      {Key? key,
      required this.stTime,
      required this.edTime,
      this.onPressed,
      required this.timeBoxStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (timeBoxStatus == TimeBoxStatus.wait) {
      return renderContainer(onPressed: onPressed, icon: Icons.check_box_outline_blank);
    } else if (timeBoxStatus == TimeBoxStatus.complete) {
      return renderContainer(onPressed: onPressed, icon: Icons.check_box);
    } else {
      return renderContainer(onPressed: onPressed, icon: Icons.disabled_by_default);
    }
  }

  Widget renderContainer({required VoidCallback? onPressed,required IconData icon}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 100.0,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 25.0,
            fontFamily: 'mynerve',
          ),
          foregroundColor: IRONCOLOR,
          side: const BorderSide(
            color: Colors.black54,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                '${DataUtil.getStringHourMinTimeFromMin(time: stTime)} ~ ${DataUtil.getStringHourMinTimeFromMin(time: edTime)}',
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              right: 0,
              top: 38,
              child: Icon(icon),
            ),
          ],
        ),
      ),
    );
  }
}
