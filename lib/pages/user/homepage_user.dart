// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../widgets/appbar_user.dart';
import '../widgets/footer_user.dart';
import '../widgets/mentor_section.dart';

class HomeUser extends StatefulWidget {
  final String userName;
  final String userId;
  final String asalKampus;
  const HomeUser({
    super.key,
    required this.userName,
    required this.userId,
    this.asalKampus = "",
  });

  @override
  State<HomeUser> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<HomeUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppBarUser(
            userName: widget.userName,
            userId: widget.userId,
            asalKampus: widget.asalKampus,
          ),
          const SizedBox(height: 24),
          
          // Top Mentors
          const MentorSection(
            title: 'Top Mentor',
            // Tanpa kategori mengambil semua mentor
          ),
          
          // Raja Matematika
          const FilteredMentorSection(
            title: 'Raja Matematika',
            keywords: ['matematika', 'kalkulus', 'statistik'],
          ),
          
          // Jago Ngoding
          const FilteredMentorSection(
            title: 'Jago Ngoding',
            keywords: ['programming', 'web', 'android', 'informatika'],
          ),
          
          // Pebisnis
          const FilteredMentorSection(
            title: 'Pebisnis',
            keywords: ['bisnis', 'manajemen', 'wirausaha'],
          ),
        ],
      ),
      bottomNavigationBar: FooterUser(
        currentIndex: 0,
        userName: widget.userName,
        userId: widget.userId, 
        asalKampus: widget.asalKampus,
      ),
    );
  }
}