import 'package:flutter/material.dart';
import 'package:my_app/core/constants.dart';
import 'package:my_app/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_fullNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      showSnackBar(context, 'Please fill in all fields.', Colors.red);
      return;
    }

    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      showSnackBar(context, 'Passwords do not match.', Colors.red);
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      // Set display name
      await userCredential.user?.updateDisplayName(
        _fullNameController.text.trim(),
      );

      showSnackBar(
        context,
        'Account created successfully! Please log in.',
        Colors.green,
      );

      // Navigate back to login
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
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
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
            ),

            const SizedBox(height: 30),

            // Full Name Field
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

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

            const SizedBox(height: 15),

            // Confirm Password Field
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            // Register Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF011835),
                  foregroundColor: Colors.white,
                ),
                onPressed: _register,
                child: const Text('Register Account'),
              ),
            ),
            TextButton(
              onPressed: () {
                showSnackBar(
                  context,
                  'Navigating to Login Page',
                  AppColors.warmWheat,
                );
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
