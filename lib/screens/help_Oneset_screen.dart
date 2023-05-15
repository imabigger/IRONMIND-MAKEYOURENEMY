import 'package:flutter/material.dart';
import 'package:iron_mind/component/sub_text.dart';
import 'package:iron_mind/screens/ex_enemy_list.dart';
import 'package:iron_mind/screens/make_own_list.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/text_style.dart';

class HelpOneSetScreen extends StatelessWidget {
  const HelpOneSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Navigator.of(context));
    
    return Scaffold(
      backgroundColor: PRIMARYCOLOR,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'In First,'
                      '\nYou should'
                      '\nset your own enemy'
                      '\n\nit would be  impossible person to be'
                      '\n\nyou have to put genuine effort into making your enemy'
                      '\n\nthis person you have to imagine everything about them'
                      '\n\nfrom start to finish'
                      '\nyou have to imagine standing next to them'
                      '\n\nThis Person is You,\nit\'s just you with a'
                      ' little bit walk about a different path or a different take on'
                      'life\n\n'
                      'it\'s you who\'s the person who does whatever supposed to do regardless of how he feels'
                      '\n\nIt\'s you with an',
                      style: MAIN_TEXT,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ExEnemyList()));
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      child: Text(
                        'IRON MIND',
                        style: MAIN_TEXT.copyWith(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: IRONCOLOR,
                        ),
                      ),
                    ),
                    const SubText(
                        content:
                            'If you want an example, click on the above text.'),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MakeOwnList()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(DARKCOLOR),
                      elevation: MaterialStateProperty.all(16.0),
                    ),
                    child: Text('make list'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
