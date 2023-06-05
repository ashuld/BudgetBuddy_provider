import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/color.dart';
import 'package:money_management/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider extends ChangeNotifier {
  Future<bool> checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLogged');
    await Future.delayed(const Duration(milliseconds: 3500));
    return loggedIn == true;
  }

  Widget buildErrorScreen() {
    return Container();
  }

  Widget buildSplashScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: prColor),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/icons8-money-bag-100.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              box30(),
              DefaultTextStyle(
                style: const TextStyle(
                  color: secColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [WavyAnimatedText('BudgetBuddy')],
                  isRepeatingAnimation: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
