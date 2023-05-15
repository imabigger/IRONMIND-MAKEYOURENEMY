import 'package:flutter/material.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/setting_argument.dart';
import 'package:iron_mind/const/text_style.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: DARKCOLOR
            ),
              child: Text(
            'Option',
            style: MAIN_TEXT,
          )),
          ListTile(
            tileColor: Colors.white.withOpacity(0),
            title: Text('change the data'),
            onTap: (){
              Navigator.of(context).pushNamed('/loading',arguments: firstSetting);
            },
          ),
          ListTile(
            tileColor: Colors.white.withOpacity(0),
            title: Text('see the list'),
            onTap: (){
              Navigator.of(context).pushNamed('/loading',arguments: listSetting);
            },
          ),
          ListTile(
            tileColor: Colors.white.withOpacity(0),
            title: Text('change the start/end time'),
            onTap: (){
              Navigator.of(context).pushNamed('/loading',arguments: timeSetting);
            },
          ),
          ListTile(
            tileColor: Colors.white.withOpacity(0),
            title: Text('View Win Count'),
            onTap: (){
              Navigator.of(context).pushNamed('/loading',arguments: viewWin);
            },
          )
        ],
      ),
    );
  }
}
