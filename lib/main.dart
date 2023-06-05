import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/functions/db_functions.dart';
import 'package:money_management/db/model/transactions.dart';
import 'package:money_management/db/model/userdata.dart';
import 'package:money_management/providers/btmnavprovider.dart';
import 'package:money_management/providers/splashprovider.dart';
import 'package:money_management/providers/userprovider.dart';
import 'package:money_management/screens/splash/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize and set up Hive database
  await Hive.initFlutter();

  // Register adapters for model classes if not already registered
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  // Open Hive boxes for storing data
  await Hive.openBox<TransactionModel>(transactiondb);
  await Hive.openBox<UserModel>(userdb);

  // Run the app with multiple providers
  runApp(MultiProvider(
    providers: [
      // Provider for managing bottom navigation state
      ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),

       // Provider for managing SplashScreen state
      ChangeNotifierProvider(create: ((context) => SplashScreenProvider())),

      //Provider for managing CreateScreen state
      ChangeNotifierProvider(create: (context) => UserProvider(),)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetBuddy',
      theme: ThemeData(
          useMaterial3: true, fontFamily: GoogleFonts.inder().fontFamily),
      debugShowCheckedModeBanner: false,
      home: const ScreenSplash(),
    );
  }
}
