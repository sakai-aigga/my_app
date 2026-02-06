import 'package:flutter/material.dart';
import 'package:my_app/core/constants.dart';
import 'package:my_app/core/utils.dart';
import 'package:my_app/pages/home.dart';
import 'package:my_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showSnackBar(context, 'Please enter email and password.', Colors.red);
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // On successful login, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      showSnackBar(context, message, Colors.red);
    } catch (e) {
      showSnackBar(context, 'An unexpected error occurred.', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('LoginPage build called');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image
            Image.asset('assets/images/logo.png', height: 120),
            const SizedBox(height: 20),

            const Text(
              'KUSOED Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(height: 30),

            // Email Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
                onPressed: _login,
                child: const Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () {
                showSnackBar(
                  context,
                  'Navigating to Register Page',
                  AppColors.warmWheat,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Create new account'),
            ),
          ],
        ),
      ),
    );
  }
}
