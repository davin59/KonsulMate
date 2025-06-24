import 'package:flutter/material.dart';

class MentorHomePage extends StatelessWidget {
  const MentorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Home Page'),
      ),
      body: const Center(
        child: Text(
          'Selamat datang, Mentor!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}