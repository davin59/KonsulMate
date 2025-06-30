import 'package:flutter/material.dart';
import 'components/appbar_mentor.dart';
import 'components/footer_mentor.dart';

class HistoryMentor extends StatelessWidget {
  final String userName;
  final String userId;

  const HistoryMentor({
    super.key,
    required this.userName,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const MentorAppBar(), // gunakan class MentorAppBar dari appbar_mentor.dart
      body: const Center(child: Text('History Mentor')),
      bottomNavigationBar: FooterMentor(
        currentIndex: 2,
        userName: userName,
        userId: userId,
      ), // gunakan class FooterMentor dari footer_mentor.dart
    );
  }
}
