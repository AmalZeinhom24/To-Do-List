import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/layout/home.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/sign_up/sign_up.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/styles/theming.dart';
import 'package:todo/screens/splash_screen/splash_scareen.dart';
import 'firebase_options.dart';
/*SQL needs engin (server) to connect on it
* but SQLLight do not need servers,
* because it deals with and creates database in the form of text files*/

Future main() async {
  //Before using async&await use the next line to ensure the everything was initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseFirestore.instance.disableNetwork();
  var pro = MyProvider();
  await pro.loadThemeData();
  await pro.loadLanguageData();

  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  print(email);

  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => pro, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(provider.currentLocal), // Set the locale for the app
        initialRoute: SplashScareen.routeName,
        routes: {
          SplashScareen.routeName: (context) => SplashScareen(),
          HomeLayout.routeName: (context) => HomeLayout(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
        },
        debugShowCheckedModeBanner: false,
        themeMode: provider.theme, // Apply the theme mode (light or dark)
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme);
  }
}
