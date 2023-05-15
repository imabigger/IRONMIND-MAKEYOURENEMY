import 'package:flutter/material.dart';
import 'package:iron_mind/const/color.dart';
import 'package:iron_mind/const/text_style.dart';
import 'package:iron_mind/layout/setting_lay_out.dart';

class ExEnemyList extends StatelessWidget {
  const ExEnemyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingLayOut(
      topText: 'The enemy model of the app developer.',
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 8.0, left: 8.0),
          color: Colors.black12,
          child: Column(
            children: const [
              EXText(),
            ],
          ),
        ),
      ),
      buttonText: 'Back',
      onPressedBottomButton: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class EXText extends StatelessWidget {
  const EXText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '1. He never tries to seek recognition from others.\n\n'
      '2. He is not ashamed to show his true self.\n\n'
      '3. He plans his own day.\n\n'
      '4. When setting long-term goals, he is not swayed by others\' opinions.\n\n'
      '5. He looks down on NPCs, but does not show it outwardly.\n\n'
      '6. When he needs to fight, he does not run away out of fear of losing.\n\n'
      '7. He challenges himself without caring about his kill/death ratio.\n\n'
      '8. He knows the world is unfair, but instead of blaming it, he writes his own story.\n\n'
      '9. Even if he feels lazy and lethargic, he still does what needs to be done.\n\n'
      '10. He never refuses to exercise.\n\n'
      '11. He takes care of his hygiene and appearance.\n\n'
      '12. He goes to bed before 12 and wakes up around 7.\n\n'
      '13. He maintains a consistent ratio of carbohydrates, protein, and fat in each meal.\n\n'
      '14. He pours effort into achieving his financial freedom.\n\n'
      '15. He spends time studying for his business every day.\n\n'
      '16. He joins or creates groups related to money, ambition, and success.\n\n'
      '17. He blocks thoughts about how women might think of him.\n\n'
      '18. He does 10 minutes of stretching every hour to avoid sitting for too long and to maintain his back health. He never exceeds the 10 minutes.\n\n'
      '19. He sets aside time to read every day.\n\n'
      '20. He does not play addictive games.\n\n'
      '21. He remains determined to achieve what he has set for himself, even if someone suggests that he can take a break.\n\n'
      '22. He hates laziness and idleness.\n\n'
      '23. He is not obsessed with his financial situation.\n\n'
      '24. He never gambles, uses drugs, or smokes.\n\n'
      '25. He knows how to reward himself for his hard work.\n\n'
      '26. He takes care of his family.\n\n'
      '27. He takes responsibility for and loves his woman.\n\n'
      '28. He is confident in his success no matter what his current situation is like.\n',
      style: TextStyle(
        fontFamily: 'oswald',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
