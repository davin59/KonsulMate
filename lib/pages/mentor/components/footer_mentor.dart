import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mentor/homepage_mentor.dart';
import '../listchat_mentor.dart';
import '../history_mentor.dart';

class FooterMentor extends StatelessWidget {
  final int currentIndex;
  final String userName;
  final String userId;

  const FooterMentor({
    super.key,
    required this.currentIndex,
    required this.userName,
    required this.userId,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget page;
    switch (index) {
      case 0:
        page = HomepageMentor(userName: userName, userId: userId);
        break;
      case 1:
        page = ListChatMentor(userName: userName, userId: userId);
        break;
      case 2:
        page = HistoryMentor(userName: userName, userId: userId);
        break;
      default:
        page = HomepageMentor(userName: userName, userId: userId);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFF80C9FF),
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
          _buildNavItem(context, 0, Icons.home_outlined),
          _buildNavItem(context, 1, Icons.chat_bubble_outline),
          _buildNavItem(context, 2, Icons.history),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon) {
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => _onItemTapped(context, index),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          color: isSelected ? Colors.yellow : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
