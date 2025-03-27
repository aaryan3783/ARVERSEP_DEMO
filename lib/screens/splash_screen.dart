import 'package:flutter/material.dart';
import '../services/session_manager.dart';
import 'signin_page.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Check if a user is already logged in
    final loggedInEmail = await SessionManager.getLoggedInEmail();

    if (loggedInEmail != null) {
      // Navigate to HomePage if logged in
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {'userEmail': loggedInEmail},
      );
    } else {
      // Navigate to SignInPage if not logged in
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}