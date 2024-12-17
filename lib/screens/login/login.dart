import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/layout/home.dart';
import 'package:todo/screens/sign_up/sign_up.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:todo/shared/styles/fade_animation.dart';
import 'package:todo/shared/styles/fade_animation.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintGreen,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FadeAnimation(
                1,
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 80,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/clock.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                          1.6,
                          Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: mintGreen,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 2),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FadeAnimation(
                                1.8,
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter your email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your Email";
                                      }

                                      final bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value);
                                      if (!emailValid) {
                                        return "Invalid email !";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            FadeAnimation(
                                2,
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter your password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your Password";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseManager.login(
                                emailController.text, passwordController.text,
                                () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  HomeLayout.routeName, (route) => false);
                            }, (message) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                        title: Text('Error'),
                                        content: Text(message),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.indigo),
                                          )
                                        ],
                                      ));
                            });
                          }
                        },
                        child: FadeAnimation(
                          2.1,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6)
                                ])),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 70),
                    FadeAnimation(
                      2.2,
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
