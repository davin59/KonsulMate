// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import '../user/homepage_user.dart';
import '../user/listchat_user.dart';
import '../user/history_user.dart';

class FooterUser extends StatelessWidget {
  final int currentIndex;
  final String userName;
  final String userId;
  final String asalKampus;
  final int? forceCurrentIndex; // Tambahkan ini

  const FooterUser({
    super.key,
    required this.currentIndex,
    required this.userName,
    required this.userId,
    this.asalKampus = "",
    this.forceCurrentIndex, // Tambahkan ini
  });

  void _onItemTapped(BuildContext context, int index) {
    if ((forceCurrentIndex ?? currentIndex) == index) return; // Perbaiki di sini

    Widget page;
    switch (index) {
      case 0:
        page = HomeUser(userName: userName, userId: userId, asalKampus: asalKampus);
        break;
      case 1:
        page = ListChatUser(userName: userName, userId: userId, asalKampus: asalKampus);
        break;
      case 2:
        page = HistoryUser(userName: userName, userId: userId, asalKampus: asalKampus);
        break;
      default:
        page = HomeUser(userName: userName, userId: userId, asalKampus: asalKampus);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 0, Icons.home_outlined, "Beranda"),
          _buildNavItem(context, 1, Icons.chat_bubble_outline, "Chat"),
          _buildNavItem(context, 2, Icons.history, "Riwayat"),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label, {
    double iconSize = 24,
  }) {
    final isSelected = (forceCurrentIndex ?? currentIndex) == index; // Ubah ini
    return InkWell(
      onTap: () => _onItemTapped(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF80C9FF) : Colors.grey,
            size: iconSize,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF80C9FF) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}