import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/signin_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';
import 'screens/edit_profile_page.dart';
import 'screens/settings_page.dart';
import 'screens/career_page.dart';
import 'screens/video_player_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        if (settings.name == '/splash') {
          return MaterialPageRoute(builder: (context) => const SplashScreen());
        } else if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => SignInPage());
        } else if (settings.name == '/signup') {
          return MaterialPageRoute(builder: (context) => SignUpPage());
        } else if (settings.name == '/home') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => HomePage(userEmail: args['userEmail']),
          );
        } else if (settings.name == '/edit_profile') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => EditProfilePage(currentEmail: args['currentEmail']),
          );
        } else if (settings.name == '/settings') {
          return MaterialPageRoute(
            builder: (context) => SettingsPage(),
          );
        } else if (settings.name == '/career') {
          return MaterialPageRoute(
            builder: (context) => CareerPage(),
          );
        } else if (settings.name == '/video_player') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => VideoPlayerPage(videoUrl: args['videoUrl']),
          );
        }
        return null;
      },
    );
  }
}