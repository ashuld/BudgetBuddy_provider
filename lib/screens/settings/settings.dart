import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/screens/settings/widgets/settingsbackground.dart';
import 'package:money_management/screens/settings/widgets/settingstiles.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secColor,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          settingsBackground(context),
          Positioned(
              top: MediaQuery.of(context).size.height * .15,
              child: settingsTiles(context))
        ],
      )),
    );
  }
}
