import 'package:flutter/material.dart';
import '../widgets/appbar_user.dart';
import '../widgets/bottom_nav_user.dart';

class SearchPage extends StatelessWidget {
  final String userName;
  
  const SearchPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E0FF),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppBarUser(userName: userName),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Ini halaman search user.\nTes berhasil!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavUser(
        currentIndex: 2, // Index 2 untuk halaman search
        userName: userName,
      ),
    );
  }
}
