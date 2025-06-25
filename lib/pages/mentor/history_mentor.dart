import 'package:flutter/material.dart';
import 'components/appbar_mentor.dart';
import 'components/footer_mentor.dart';

class HistoryMentor extends StatelessWidget {
  const HistoryMentor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MentorAppBar(), // gunakan class MentorAppBar dari appbar_mentor.dart
      body: const Center(child: Text('History Mentor')),
      bottomNavigationBar: const MentorFooter(), // gunakan class FooterMentor dari footer_mentor.dart
    );
  }
}