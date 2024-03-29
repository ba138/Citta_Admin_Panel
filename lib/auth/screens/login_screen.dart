// ignore_for_file: use_build_context_synchronously

import 'package:citta_admin_panel/auth/screens/register_screen.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/screens/main_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  void loginUser() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        User? user = await signInWithEmailAndPassword(
            usernameController.text, passwordController.text);
        if (user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => const MainScreen()),
              (route) => false);
          Fluttertoast.showToast(
            msg: "Login Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
          );
        } else {
          Fluttertoast.showToast(
            msg: "InValid arguments",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
          );
        }
      } on FirebaseException catch (error) {
        errorDialog(subtitle: '${error.message}', context: context);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        errorDialog(subtitle: '$error', context: context);
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      body: LoadingManager(
        isLoading: isLoading,
        child: Row(
          children: [
            // if (Responsive.isDesktop(context))
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/groceries.png"),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          TextWidget(
                            text: 'Seller Point',
                            color: color,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width > 650 ? 650 : size.width,
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextWidget(
                              text: 'Email*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: usernameController,
                              key: const ValueKey('Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter user Email';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Password*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              key: const ValueKey('Password'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Password';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Center(
                                child: InkWell(
                                  onTap: () async {
                                    loginUser();
                                    // signinUser();
                                  },
                                  child: Container(
                                    height: 46,
                                    width: 300,
                                    color: const Color(0xFFCB0166),
                                    child: const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have account?",
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (c) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Signup",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/warning-sign.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("An Error occured"),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: TextWidget(
                  text: "ok",
                  color: Colors.cyan,
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
}
