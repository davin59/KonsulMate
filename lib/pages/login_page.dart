// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'lib/pages/user/user_home_page.dart';
import 'lib/pages/mentor/mentor_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isMentorSelected = false; // default: user

  Future<Map<String, dynamic>> loadJsonData() async {
    String data = await rootBundle.loadString('assets/data/dummy.json');
    return json.decode(data);
  }

  void handleMasuk(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    final jsonData = await loadJsonData();

    String role = isMentorSelected ? 'mentor' : 'user';
    final dataList = jsonData[role] as List;
    final user = dataList.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isMentorSelected ? const MentorHomePage() : const UserHomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top Section - Logo and Tagline
            Container(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
              color: Colors.white, 
              child: Column(
                children: [
                  const Text(
                    'KonsulMate',
                    style: TextStyle(
                      fontFamily: 'chewy', 
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Membantu Menemukan',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Mentor Terbaikmu',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Illustration (replace with your actual image assemt)
                  Image.asset(
                    'assets/images/illustration.png', 
                    height: 200,
                  ),
                ],
              ),
            ),

            // Bottom Section - Login Form
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Color(0xFF87CEEB), 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isMentorSelected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isMentorSelected
                                ? Colors.blue[900]
                                : Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login Mentor',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isMentorSelected = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !isMentorSelected
                                ? Colors.blue[900]
                                : Colors.blue[800],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login User',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Daftar (Register)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800], // Darker blue
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            handleMasuk(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800], // Darker blue
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Sign in with another method',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.email, size: 30, color: Colors.black54),
                        onPressed: () {
                          // Handle email login
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.facebook, size: 30, color: Colors.blue), 
                        onPressed: () {
                          // Handle Facebook login
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.travel_explore, size: 30, color: Colors.lightBlueAccent), 
                        onPressed: () {
                          // Handle Twitter login
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}