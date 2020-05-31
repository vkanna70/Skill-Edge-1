import 'package:flash_chat/notifier/skill_notifier.dart';
import 'package:flash_chat/notifier/teammember_notifier.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        child: SkillEdge(),
        providers: [
//        ChangeNotifierProvider(
//          create: (context) => AuthNotifier(),
//        ),
          ChangeNotifierProvider(
            create: (context) => TeamMemberNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => SkillsNotifier(),
          ),
        ],
      ),
    );

class SkillEdge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<TeamMemberNotifier>(builder: (context, notifier, child) {
        return WelcomeScreen();
      }),
    );
  }
}

//backup - nested consumers - didn't work. so wrapped invocation of SkilldetailScreen on tap from TeamMemberDetail screen
//class SkillEdge extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return MaterialApp(
////      debugShowCheckedModeBanner: false,
////      home: Consumer<TeamMemberNotifier>(
////        builder: (context, notifier, child) {
////          Consumer<SkillsNotifier>(
////            builder: (context, notifier, child) {
////              return WelcomeScreen();
////            },
////          );
////        },
////      ),
////    );
////  }
////}

//Old version (before refactoring for model based implementation)
//void main() => runApp(SkillEdge());
//
//class SkillEdge extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: WelcomeScreen(),
//    );
//  }
//}
