import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/shared/styles/colors.dart';

class SplashScareen extends StatefulWidget {
  static const String routeName = "splash";

  @override
  State<SplashScareen> createState() => _SplashScareenState();
}

class _SplashScareenState extends State<SplashScareen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), SplashNanigator);
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Container(
        color: pro.isDarkMode? Color(0xFF060E1E) : mintGreen,
        child: Center(child: Image.asset("assets/images/logo.png")),
      ),
    );
  }

  SplashNanigator() {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, (route) => false);
  }
}
