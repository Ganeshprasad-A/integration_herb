import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:herbalhub/frontend/screens/front_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showDialog('Error', 'Please enter both username and password.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://10.21.208.200:3000/login'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Login successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BookmarkedPlantsScreen()),
        );
      } else if (response.statusCode == 404) {
        // User not found
        _showRegisterDialog(username, password);
      } else if (response.statusCode == 401) {
        // Invalid password
        _showDialog('Invalid Credentials', 'The password is incorrect.');
      } else {
        _showDialog('Error', 'Unexpected error occurred.');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showDialog('Error', 'Failed to connect to the server.');
    }
  }

  Future<void> registerUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _showDialog('Error', 'Please provide both username and password.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://10.21.208.200:3000/register'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        _showDialog('Success', 'Registration successful! You can now log in.');
      } else if (response.statusCode == 400) {
        _showDialog('Error', 'Username already exists.');
      } else {
        _showDialog('Error', 'Unexpected error occurred.');
      }
    } catch (error) {
      _showDialog('Error', 'Failed to connect to the server.');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRegisterDialog(String username, String password) {
    final TextEditingController usernameController =
        TextEditingController(text: username);
    final TextEditingController passwordController =
        TextEditingController(text: password);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Not Found'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Enter username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Enter password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newUsername = usernameController.text.trim();
              final newPassword = passwordController.text.trim();
              Navigator.pop(context);
              registerUser(newUsername, newPassword);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Avoid overflow when keyboard appears
      backgroundColor: const Color(0xFFE7F6D4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'lib/frontend/assets/images/ayushlogo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 40),
                  // Username input
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD7E9B9),
                      hintText: 'Enter username or email',
                      prefixIcon:
                          Icon(Icons.person, color: Colors.green.shade700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password input
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD7E9B9),
                      hintText: 'Enter password',
                      prefixIcon:
                          Icon(Icons.lock, color: Colors.green.shade700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Login button
                  ElevatedButton(
                    onPressed: _isLoading ? null : loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
