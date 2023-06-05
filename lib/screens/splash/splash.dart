import 'package:flutter/material.dart';
import 'package:money_management/providers/splashprovider.dart';
import 'package:money_management/screens/register/create.dart';
import 'package:money_management/widgets/bottomnavigation.dart';
import 'package:provider/provider.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashScreenProvider>(
        builder: (context, splashBuilder, child) {
      // Build the UI based on the future result using a FutureBuilder
      return FutureBuilder<bool>(
        future: splashBuilder.checkLoggedInStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show the splash screen while waiting for the future to complete
            return splashBuilder.buildSplashScreen(context);
          } else {
            if (snapshot.hasError) {
              // Show an error screen if there was an error while fetching data
              return splashBuilder.buildErrorScreen();
            } else {
              // Check the logged-in status and return the appropriate screen
              final bool loggedIn = snapshot.data!;
              return loggedIn
                  ? const BottomNavigation()
                  : const ScreenCreateAccount();
            }
          }
        },
      );
    });
  }
}
