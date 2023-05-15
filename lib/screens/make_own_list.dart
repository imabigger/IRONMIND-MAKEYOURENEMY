import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/component/input_list_text_field.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/layout/setting_lay_out.dart';
import 'package:iron_mind/layout/setting_lay_out_two.dart';
import 'package:iron_mind/model/status_model.dart';

class MakeOwnList extends StatefulWidget {
  const MakeOwnList({Key? key}) : super(key: key);

  @override
  State<MakeOwnList> createState() => _MakeOwnListState();
}

class _MakeOwnListState extends State<MakeOwnList> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int tfTotal = 1;
  List<String?> contentList = List.generate(40, (index) => null);
  final box = Hive.box<StatusModel>(userBox);

  @override
  void initState() {
    // TODO: implement initState

    final StatusModel status = box.values.last; //가장 최근 모델
    if(status.comList.isEmpty){
      status.comList.add('');
    }

    tfTotal = status.comList.length;

    for(int i=0; i<tfTotal;i++){
      contentList[i] = status.comList[i];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = box.values.last;


    if(status.comList.length < tfTotal) {
      status.comList.add(contentList[tfTotal-1]!);
    }else if(status.comList.length > tfTotal){
      status.comList.removeAt(tfTotal);
    }

    for(int i=0; i<tfTotal;i++){
      status.comList[i] = contentList[i]!;
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SettingLayOutTwo(
        topText: 'Make List',
        floatingActionButton: renderBackFloatingActionButton(context),
        buttonText: 'Save',
        onPressedBottomButton: () {
          onSavePressed();
        },
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  tfTotal,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputListTextField(
                      textIndex: index + 1,
                      onChanged: (String? newValue) {
                        formKey.currentState!.validate();
                        setState(() {
                          contentList[index] = newValue;
                        });
                      },
                      initialValue: contentList[index] ?? '',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if(tfTotal <40 ) {
                            tfTotal++;
                            contentList[tfTotal-1] = '';
                          }
                        });
                      },
                      icon: Icon(Icons.add,size: 32.0),
                      color: DARKCOLOR,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if(tfTotal > 1) {
                            tfTotal--;
                            contentList[tfTotal] = null;
                          }
                        });
                      },
                      icon: Icon(Icons.remove, size: 32.0),
                      color: DARKCOLOR,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState == null) {
      //key가 form 위젯과 결합을 못했을때
      return;
    }

    if (formKey.currentState!.validate()) {
      //form 아래 textformfield들의 validator 실행
      formKey.currentState!.save();

      final String key = box.keys.last;
      final StatusModel status = box.values.last;
      await box.deleteAt(0);
      await box.put(key, status);


      Future.delayed(Duration(seconds: 0)).then((value) {
        Navigator.of(context).pushReplacementNamed('/two');
      });

    } else {
      //string 반환이 하나라도 있다면
    }
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
}
