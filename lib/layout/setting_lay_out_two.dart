import 'package:flutter/material.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/text_style.dart';

class SettingLayOutTwo extends StatelessWidget {
  final String topText;
  final String buttonText;
  final Widget body;
  final Widget? floatingActionButton;
  final VoidCallback onPressedBottomButton;
  final Color? backgroundcolor;

  const SettingLayOutTwo(
      {required this.topText,
      required this.body,
      required this.buttonText,
      required this.onPressedBottomButton,
      this.floatingActionButton,
        this.backgroundcolor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: CustomFabLoc(context: context),
      backgroundColor: PRIMARYCOLOR,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                width: MediaQuery.of(context).size.width,
                color: backgroundcolor ?? Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Align(
                        child: Text(
                          topText,
                          style: MAIN_TEXT.copyWith(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child:
                            body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: onPressedBottomButton,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(DARKCOLOR),
                  elevation: MaterialStateProperty.all(16.0),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFabLoc extends FloatingActionButtonLocation {
  final BuildContext context;

  CustomFabLoc( {required this.context});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
          scaffoldGeometry.floatingActionButtonSize.width
      - 25.0,
      MediaQuery.of(context).size.height * 0.05 + 16.0,
    );
  }
}
