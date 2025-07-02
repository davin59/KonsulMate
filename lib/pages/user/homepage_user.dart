// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/appbar_user.dart';
import '../widgets/footer_user.dart';
import '../widgets/mentor_section.dart'; // Import widget baru

class HomeUser extends StatefulWidget {
  final String userName;
  final String userId;
  final String asalKampus; // Tambahkan ini
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
  List<dynamic> mentors = [];

  @override
  void initState() {
    super.initState();
    loadMentors();
  }

  Future<void> loadMentors() async {
    String data = await rootBundle.loadString('assets/data/dummy.json');
    final jsonData = json.decode(data);
    setState(() {
      mentors = jsonData['mentor'];
    });
  }

  List<dynamic> filterAndSortMentor(List<String> keywords) {
    final filtered =
        mentors.where((m) {
          final keahlian = (m['keahlian'] ?? '').toString().toLowerCase();
          final prodi = (m['prodi'] ?? '').toString().toLowerCase();
          return keywords.any((k) => keahlian.contains(k) || prodi.contains(k));
        }).toList();
    filtered.sort(
      (a, b) => (b['rateing'] as num).compareTo(a['rateing'] as num),
    );
    return filtered;
  }

  dynamic getTopMentor() {
    if (mentors.isEmpty) return null;
    mentors.sort(
      (a, b) => (b['rateing'] as num).compareTo(a['rateing'] as num),
    );
    return mentors.first;
  }

  @override
  Widget build(BuildContext context) {
    final rajaMtk = filterAndSortMentor([
      'matematika',
      'aljabar',
      'kalkulus',
      'statistik',
      'logika',
    ]);
    final jagoNgoding = filterAndSortMentor([
      'programming',
      'web',
      'android',
      'informatika',
      'developer',
      'coding',
    ]);
    final pebisnis = filterAndSortMentor([
      'bisnis',
      'manajemen',
      'wirausaha',
      'startup',
      'umkm',
      'marketing',
    ]);
    final topMentor = getTopMentor();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppBarUser(
              userName: widget.userName,
              asalKampus: widget.asalKampus, // Kirim asalKampus ke AppBarUser
            ),
            const SizedBox(height: 24),
            MentorSection(
              title: 'Top Mentor',
              mentorList: topMentor != null ? [topMentor] : [],
            ),
            MentorSection(title: 'Raja Matematika', mentorList: rajaMtk),
            MentorSection(title: 'Jago Ngoding', mentorList: jagoNgoding),
            MentorSection(title: 'Pebisnis', mentorList: pebisnis),
          ],
        ),
      ),
      bottomNavigationBar: FooterUser(
        currentIndex: 0,
        userName: widget.userName,
        userId: widget.userId,
      ),
    );
  }
}
