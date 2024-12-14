import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/settings/widgets/action_buttons.dart';
import 'package:todo/screens/settings/widgets/edit_items.dart';
import 'package:todo/shared/styles/colors.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
            )),
        leadingWidth: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              EditItems(
                title: 'Photo',
                widget: Column(
                  children: [
                    Image.asset(
                      'assets/images/avatar.png',
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent),
                      onPressed: () {},
                      child: Text(
                        'Upload Image',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              EditItems(title: "Name", widget: TextField()),
              SizedBox(height: 20),
              EditItems(title: "Email", widget: TextField()),
              SizedBox(height: 20),
              EditItems(title: "Password", widget: TextField()),
              SizedBox(height: 40),
              Row(
                children: [
                  ActionButtons(title: 'Delete Account'),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove('email');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return LoginScreen();
                        }));
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
