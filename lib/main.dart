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
      theme: ThemeData(
        // Define the default brightness and colors.
//        brightness: Brightness.dark,
        primaryColor: Color(0xFF2A2969),
        accentColor: Color(0xFFFBAB19),

        // Define the default font family.
//        fontFamily: 'Georgia',
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<TeamMemberNotifier>(builder: (context, notifier, child) {
        return WelcomeScreen();
      }),
    );
  }
}
