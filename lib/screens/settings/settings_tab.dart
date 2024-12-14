/*
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/settings/bottom_sheets/show_language_bottom_sheet.dart';
import 'package:todo/screens/settings/bottom_sheets/show_theming_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            pro.local == "en"
                ? AppLocalizations.of(context)!.language
                : AppLocalizations.of(context)!.language,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.deepPurple),
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet(context);
            },
            child: Container(

              margin: EdgeInsets.symmetric(horizontal: 18),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: Text(
                pro.local == "en"
                    ? AppLocalizations.of(context)!.english
                    : AppLocalizations.of(context)!.arabic,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepPurple),
              ),
            ),
          ),
          SizedBox(height: 18),
          Text(pro.local == "en"
              ? AppLocalizations.of(context)!.mode
              : AppLocalizations.of(context)!.mode,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple)),
          InkWell(
            onTap: () {
              showThemingBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: Text(
                pro.theme == ThemeMode.light
                    ? AppLocalizations.of(context)!.light
                    : AppLocalizations.of(context)!.dark,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return ShowLanguageBottomSheet();
      },
    );
  }

  void showThemingBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ShowThemingBottomSheet();
      },
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/my_provider.dart';
import 'package:todo/screens/settings/edit_account_screen.dart';
import 'package:todo/screens/settings/widgets/forward_button.dart';
import 'package:todo/screens/settings/widgets/language_bottom_sheet.dart';
import 'package:todo/screens/settings/widgets/settings_items.dart';
import 'package:todo/screens/settings/widgets/settings_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<MyProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.settings,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              Text(AppLocalizations.of(context)!.account,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset('assets/images/avatar.png',
                        width: 70, height: 70),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.accountName,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        SizedBox(height: 5),
                        Text(AppLocalizations.of(context)!.personalInfo,
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                    Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAccountScreen(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(AppLocalizations.of(context)!.settings,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              SettingsItems(
                title: AppLocalizations.of(context)!.language,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                icon: Ionicons.earth,
                value: settings.currentLocal == 'en' ? 'English' : 'العربية',
                onTap: (){
                  showLanguageBottomSheet(context);
                },
              ),
              SizedBox(height: 20),
              SettingsItems(
                title: AppLocalizations.of(context)!.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                icon: Ionicons.notifications,
              ),
              SizedBox(height: 20),
              SettingsSwitch(
                title: AppLocalizations.of(context)!.dark,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                icon: (Icons.dark_mode),
                value: settings.isDarkMode,
                onTap: (value) {
                  settings.changeTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
              SizedBox(height: 20),
              SettingsItems(
                title: AppLocalizations.of(context)!.help,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                icon: Ionicons.nuclear,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (context) => LanguageBottomSheet(),
    );
  }
}
