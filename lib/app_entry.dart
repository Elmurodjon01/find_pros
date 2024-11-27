import 'package:find_pros/home/view/home_view.dart';
import 'package:find_pros/social/social_page.dart';
import 'package:flutter/material.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SocialView(),
    );
  }
}
