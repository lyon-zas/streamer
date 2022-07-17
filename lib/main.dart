import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamer/recources/user_provider.dart';
import 'package:streamer/screens/login.dart';
import 'package:streamer/screens/signup.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/email.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/live_stream.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/persons.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/users.dart';
import 'package:streamer/screens/web_homepage/Sidebar_pages/video.dart';
import 'package:streamer/screens/web_homepage/web_homepage.dart';
import 'package:streamer/utils/colors.dart';

import 'resources/auth_method.dart';
import 'screens/home_page.dart';
import 'screens/web_homepage/side_menu.dart';
import 'screens/web_login.dart';
import 'model/user.dart' as model;
import 'widgets/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBKksXTsvHi6OKGwNyo_1dzmWiBr_Fah44",
            appId: "1:569023695979:web:69325b30bfd1f28bfbf52e",
            messagingSenderId: "569023695979",
            storageBucket: "stremmer-c7617.appspot.com",
            projectId: "stremmer-c7617"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'streamer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      routes: {
        // OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUp.routeName: (context) => const SignUp(),
        HomePage.routeName: (context) => const HomePage(),
        WebLogin.routeName: (context) => const WebLogin(),
        WebhomePage.routeName: (context) => const WebhomePage(),
      },
      home: FutureBuilder(
        future: AuthMethods()
            .getCurrentUser(FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null)
            .then((value) {
          if (value != null) {
            Provider.of<UserProvider>(context, listen: false).setUser(
              model.User.fromMap(value),
            );
          }
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          if (snapshot.hasData) {
            return kIsWeb ? const WebhomePage() : HomePage();
          }
          return kIsWeb ? const WebLogin() : LoginScreen();
        },
      ),
      // kIsWeb ? const WebLogin() : LoginScreen(),
    );
  }
}

//   FirebaseOptions(
    //       apiKey: "AIzaSyBKksXTsvHi6OKGwNyo_1dzmWiBr_Fah44",
    //       authDomain: "stremmer-c7617.firebaseapp.com",
    //       projectId: "stremmer-c7617",
    //       storageBucket: "stremmer-c7617.appspot.com",
    //       messagingSenderId: "569023695979",
    //       appId: "1:569023695979:web:69325b30bfd1f28bfbf52e",
    //       measurementId: "G-X4QCGCXN3E"),
    // );

