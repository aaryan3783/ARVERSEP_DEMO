import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'signup_page.dart';
import 'home_page.dart';
// import '../services/auth_service.dart'; // Import AuthService

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool rememberMe = false;
  // final AuthService authService = AuthService(); // Create instance of AuthService
  void loginUser() async {
    String email = emailController.text.trim();
  String password = passwordController.text.trim();

  // Check if fields are empty
  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Email and Password are required")),
    );
    return;
  }

  // Simple email format validation
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter a valid email address")),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  await Future.delayed(const Duration(seconds: 2)); // Simulated loading

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );

  setState(() {
    isLoading = false;
  });

    
    // setState(() {
    //   isLoading = true;
    // });

    // String email = emailController.text.trim();
    // String password = passwordController.text.trim();

    // if (email.isEmpty || password.isEmpty) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Please enter email and password")),
    //   );
    //   return;
    // }
    // print("hello");
    // String response = await authService.login(email, password);
    // print("world");
    // setState(() {
    //   isLoading = false;
    // });

    // if (response == "success") {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(response)),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 80),
            const SizedBox(height: 16),
            const Text(
              "SIGN IN TO YOUR ACCOUNT",
              style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.underline,
                decorationColor: Colors.green,
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email@gmail.com",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Password",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    const Text("Remember"),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ],
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: "SIGN IN", onPressed: loginUser),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("or sign with"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/facebook.png", width: 40),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Image.asset("assets/google.png", width: 40),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
