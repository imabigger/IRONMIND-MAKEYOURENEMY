

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/model/status_model.dart';
import 'package:iron_mind/screens/first_screen.dart';
import 'package:iron_mind/screens/help_Oneset_screen.dart';
import 'package:iron_mind/screens/help_fourset_screen.dart';
import 'package:iron_mind/screens/help_threeset_screen.dart';
import 'package:iron_mind/screens/help_twoset_screen.dart';
import 'package:iron_mind/screens/loading_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();



  /*// Run this before displaying any ad. in ios
  await Admob.requestTrackingAuthorization();*/

  await Hive.initFlutter();

  Hive.registerAdapter<StatusModel>(StatusModelAdapter());
  Hive.registerAdapter<TimeInterval>(TimeIntervalAdapter());

  Hive.registerAdapter<TimeBoxStatus>(TimeBoxStatusAdapter());
  Hive.registerAdapter<TimeBoxModel>(TimeBoxModelAdapter());

  await Hive.openBox<StatusModel>(userBox);
  await Hive.openBox<TimeBoxModel>(userTime);


  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'gajrajone',
      ),

      initialRoute: '/',
      routes: {
        '/' : (context) => FirstScreen(),
        '/one' : (context) => HelpOneSetScreen(),
        '/two' : (context) => HelpTwoSetScreen(),
        '/three' : (context) => HelpThreeSetScreen(),
        '/four' : (context) => HelpFourSetScreen(),
        '/loading' : (context) => LoadingScreen(),
      },
    ),
  );
}
