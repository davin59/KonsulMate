import 'package:flutter/material.dart';
import '../widgets/appbar_user.dart';
import '../widgets/bottom_nav_user.dart';

class UserHistoryPage extends StatelessWidget {
  final String userName;
  
  const UserHistoryPage({super.key, required this.userName});

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
                'Ini halaman riwayat user.\nTes berhasil!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavUser(
        currentIndex: 3, // Index 3 untuk halaman history
        userName: userName,
      ),
    );
  }
}
