import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app_task/screen/register_screen.dart';
import 'package:user_app_task/screen/user_registrations_screen.dart';

import '../model/login_model.dart';
import '../service/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false, obscurePassword = true;

  ApiService apiService = new ApiService();
  String? usernameError;
  String? passwordError;

  // validation
  bool validate() {
    if (usernameController.text.isEmpty) {
      setState(() {
        usernameError = "Username is required";
      });
      return false;
    }
    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = "Password is required";
      });
      return false;
    }
    return true;
  }

  // api call
  Future<void> login() async {
    if (!validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // request
      LoginRequest loginRequest = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
        expiresInMins: 30,
      );

      // send request service
      final LoginResponse loginResponse = await apiService.login(loginRequest);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserListScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  InputDecoration inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      hintText: hintText,
      errorText: errorText,
      prefixIcon: Icon(prefixIcon, color: Colors.grey.shade700),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // username TextField
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              // decoration: InputDecoration(labelText: "Username"),
              decoration: inputDecoration(
                hintText: 'Username',
                prefixIcon: Icons.account_circle_outlined,
                errorText: usernameError,
              ),
            ),
            SizedBox(height: 20),
            // password TextField
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: obscurePassword,
              // decoration: InputDecoration(labelText: "Password"),
              decoration: inputDecoration(
                hintText: 'Password',
                prefixIcon: Icons.lock,
                errorText: passwordError,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade600,
                    size: 28,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
              onPressed: () {
                isLoading ? null : login();
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      "SIGN IN",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
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
