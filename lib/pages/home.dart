import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSidebarOpen = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Positioned.fill(
            child: Scaffold(
              appBar: AppBar(title: const Text('Home')),
              body: const Center(child: Text('Welcome to the Home Page!')),
            ),
          ),
          // Sidebar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: _isSidebarOpen ? 0 : -200,
            top: 0,
            bottom: 0,
            width: 200,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF011835),
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user?.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user?.email ?? 'email@example.com',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF011835),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Toggle button
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              onPressed: _toggleSidebar,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isSidebarOpen
                    ? const Icon(Icons.close, key: ValueKey('close'))
                    : const Icon(Icons.menu, key: ValueKey('menu')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
