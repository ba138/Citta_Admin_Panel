import 'package:citta_admin_panel/auth/screens/login_screen.dart';
import 'package:citta_admin_panel/auth/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'providers/dark_theme_provider.dart';
// import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDnfN9Ewo1r0_5XqoZ6SqdwgUD2IurbICE",
        authDomain: "citta-23-2b5be.firebaseapp.com",
        projectId: "citta-23-2b5be",
        storageBucket: "citta-23-2b5be.appspot.com",
        messagingSenderId: "1098406014436",
        appId: "1:1098406014436:web:2da9b291fd9d9386b86bf1",
        measurementId: "G-541Q4GM7Q7",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
