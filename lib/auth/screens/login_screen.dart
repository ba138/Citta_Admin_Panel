import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 5,
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
                                    image: AssetImage(
                                        "assets/images/groceries.png"),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            TextWidget(
                              text: 'Saller Point',
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
                                  child: Container(
                                    height: 46,
                                    width: 300,
                                    color: const Color(0xFFCB0166),
                                    child: const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have account?",
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "Signup",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
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
}
