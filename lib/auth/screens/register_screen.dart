// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';

import 'package:citta_admin_panel/auth/screens/login_screen.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/screens/main_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage = f;
          _pickedImage = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<String> _uploadImageToStorage(String uuid, File? imageFile) async {
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child('seller_profile')
          .child("${uuid}jpg");
      if (kIsWeb) {
        await storage.putData(webImage);
      } else {
        await storage.putFile(_pickedImage!);
      }

      // Get download URL
      String imageUrl = await storage.getDownloadURL();
      return imageUrl;
    } catch (error) {
      // Handle the error
      return "";
    }
  }

  void createUser() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      final _uuid = const Uuid().v1();
      if (_pickedImage == null) {
        errorDialog(subtitle: 'Please pick up an image', context: context);
        return;
      }
      try {
        setState(() {
          isLoading = true;
        });
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        final imageUrl = await _uploadImageToStorage(_uuid, _pickedImage!);
        await FirebaseFirestore.instance
            .collection('Saller')
            .doc(auth.currentUser!.uid)
            .set({
          'id': _uuid,
          'name': usernameController.text,
          'email': emailController.text,
          'profilePic': imageUrl,
        });
        Fluttertoast.showToast(
          msg: "User Create succefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: ,
          // textColor: ,
          // fontSize: 16.0
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => const MainScreen()),
            (route) => false);
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
            if (Responsive.isDesktop(context))
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
                              Center(
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  backgroundImage: _pickedImage != null
                                      ? MemoryImage(webImage)
                                      : const NetworkImage(
                                          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAMAAACahl6sAAAAMFBMVEXU1NT////Y2Nj7+/va2trm5ubz8/Pf39/29vbe3t7j4+P8/Pzt7e3Z2dn09PTp6enlgXfuAAAEj0lEQVR4nO2dCZarOgxEMVPCkGT/u31N8+mEEIIHVUmf47sC6ghNRhZFkclkMplMJpPJZDKZTCaTyWQymUwmk8lsKLuu75sf+r7rSu2niaNrxrZyK6p2bDrt5wqibtrB7TC0Ta39fH6Uj+ueiIXrw/5r1rdHKmbaXvtJv9JUxxL+PKbRfto9yhAZsxSTb1gfKONXir0XrPb0jXdaYyHssRtujxge2s/+wu0w4H7jetN+/oU+2hz/GcWIp4xpMiZGbQ0TkV6+ptVWUZR3CR3O3ZVTSpnk5q9cVZWUEUlwj0pRiZw9JhRtIuQfC3ctHSLx6hWl2PWQ1uGcSrlykdfh3IWvQzJgPVEIXeIOMkN3kwajwzlyA1wmFrz7DNyXS6Di3YNaCXc4Hc4xDyNFS5N3rjwdPVKHc7yGEWoQokkgOf0VVn4HG4RmEmjImuEELmAOWeDkEki1uKZi6ADH3hlGBAaVvWsYRTCsXHxlwOuAJ5EZfCoBdOqfwHfv8Gw4A8+JJUeHc+j+iuQieCeB9ervoHt3Qn0yg65SKOlwAp0SCYXWDLrcYulwDquDFn3R8bfmCcGORBC6wwVsl3gaIbTEjk7tlPZwBtsknsYip/GR0wg5TR45TYlynqKR1LLjm/bT9COk0yD8edBpDh9OcxzEClv4DwukYxT8px5S/Yv/QEJyEsJECiUlMr7rUg5NGcNOlHeLMutEqFI4c3SEuEUaq4HnRMpn9oLg7qy5RtxA4wxvrBFcy/PmsTHDywvMIWaol1Anf4F1CnE2s4Ae1JGv7sPaEvZNPpS/868r1JBkMijcQYaUXCqXXQFuonTVVTwGcyPvE2mH17tS2Yk6/KC4/KWTvOKqusSmFlNSKS9/kFKiraMobiJKKgN7HySuUOteZv8jOTOaWPkwcUl6vSqFC7p7lAmHdq2N12ohdjeKlZ0oT25RnjIaiFYbuuDwdbW6ke4S5CqtISff0Hi7ymB24VlR9mNQGK7G3lbA+qVsonaL3I1tb/PdBfgJO/sB67A3aks1qpe+P1xE1tXctSPYRW6bk6aUXnYJkpazyFnjT4qGVW6Qr9QtvfaKX8z4HfLaxph1n74Q14KmtFE+sFqttMbWB07zSxmhwx9H1KxLx+CqJXVtqT/YZp42vjwBDMS0i7ozKEeRXS/pA+YkVe4Lgj+IM3oNHQglOjrklWjpkFYi+a0wWIngcaSePX6ViNkEOzDnoUQoCvPzxztC+YR2P2wfkclscl3yGYFqhbbR5TvJZ/fEW8bfSQzC2gHrSWLoMuDoC0kOb8RBZhLcBDOAGUvC4KZ6JlwTPSlI7dB9iOzibb1YE5Evl6GItRAVuYi7XPyJOOyykwpfiUiLJmrFLcHVI/pCWCzBF8mMGiTYJFYNEmwSswYJNMnNrEF+TBLy4dewQYJMYtdDJgK8xFy1uMa/djSZ1J943xInLpqLw/frtcGyd41nEUzcVxqLn7sbd/UJP3c31ql/wqt7Jy7+i8en5zV1lrWHzxmX8E8OMXj8OvF/ELMmjuOWyTOHLcenEOaz4cxxTjRd+D7Z/KDkH+MbT03dnEr6AAAAAElFTkSuQmCC',
                                          scale:
                                              10.0) as ImageProvider<Object>?,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: _pickImage,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: const Color(0xFFCB0166),
                                      )),
                                ),
                              ),

                              //  ButtonsWidget(
                              //   onPressed: _pickImage,
                              //   text: "Select Image",
                              // ),

                              const SizedBox(
                                height: 20,
                              ),
                              TextWidget(
                                text: 'Name*',
                                color: color,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: usernameController,
                                key: const ValueKey('Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter user Name';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextWidget(
                                text: 'Email*',
                                color: color,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: emailController,
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
                                    onTap: () {
                                      createUser();
                                    },
                                    child: Container(
                                      height: 46,
                                      width: 300,
                                      color: const Color(0xFFCB0166),
                                      child: const Center(
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
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
                                      "Already have account?",
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (c) => const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Signin",
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
