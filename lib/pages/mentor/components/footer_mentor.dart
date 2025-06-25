import 'package:flutter/material.dart';
import '../listchat_mentor.dart'; // Pastikan path ini sesuai
import '../history_mentor.dart'; // Tambahkan import ini

class MentorFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const MentorFooter({super.key, this.currentIndex = 1, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue.shade600,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_outlined),
          label: '',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        if (onTap != null) {
          onTap!(index);
        }
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListChatMentor()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryMentor()),
          );
        }
      },
    );
  }
}