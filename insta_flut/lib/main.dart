import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_flut/provider/user_provider.dart';
import 'package:insta_flut/responsive/mobile_screen_layout.dart';
import 'package:insta_flut/responsive/responsive_layout_screen.dart';
import 'package:insta_flut/responsive/web_screen_layout.dart';
import 'package:insta_flut/screens/login_screen.dart';
import 'package:insta_flut/utils/colors.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCZczSJY0WUwjk084EjBcA5HqdEKGXt8Ig",
            authDomain: "instaflutter-444aa.firebaseapp.com",
            projectId: "instaflutter-444aa",
            storageBucket: "instaflutter-444aa.appspot.com",
            messagingSenderId: "1035951042202",
            appId: "1:1035951042202:web:c1f9c9056c79d449777923"));
  }else{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        //
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenlayout(),
                  webScreenLayout: WebScreenlayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
