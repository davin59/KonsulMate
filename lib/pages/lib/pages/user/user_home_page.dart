import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home Page'),
      ),
      body: const Center(
        child: Text(
          'Selamat datang, User!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}