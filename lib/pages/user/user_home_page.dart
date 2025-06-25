// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/appbar_user.dart';
import '../widgets/bottom_nav_user.dart';

class UserHomePage extends StatefulWidget {
  final String userName;
  const UserHomePage({super.key, required this.userName});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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
    final filtered = mentors.where((m) {
      final keahlian = (m['keahlian'] ?? '').toString().toLowerCase();
      final prodi = (m['prodi'] ?? '').toString().toLowerCase();
      return keywords.any((k) => keahlian.contains(k) || prodi.contains(k));
    }).toList();
    filtered.sort((a, b) => (b['rateing'] as num).compareTo(a['rateing'] as num));
    return filtered;
  }

  dynamic getTopMentor() {
    if (mentors.isEmpty) return null;
    mentors.sort((a, b) => (b['rateing'] as num).compareTo(a['rateing'] as num));
    return mentors.first;
  }

  Widget mentorCard(dynamic mentor) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue[200],
                child: Text(
                  mentor['nama'][0],
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mentor['nama'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              mentor['asal_kampus_alumni'],
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              mentor['prodi'],
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              mentor['keahlian'],
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text(
                  mentor['rateing'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget section(String title, List<dynamic> mentorList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.lightBlue[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 220,
          child: mentorList.isEmpty
              ? const Center(child: Text('Tidak ada mentor'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mentorList.length > 5 ? 5 : mentorList.length,
                  itemBuilder: (context, index) {
                    return mentorCard(mentorList[index]);
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final rajaMtk = filterAndSortMentor(['matematika', 'aljabar', 'kalkulus', 'statistik', 'logika']);
    final jagoNgoding = filterAndSortMentor(['programming', 'web', 'android', 'informatika', 'developer', 'coding']);
    final pebisnis = filterAndSortMentor(['bisnis', 'manajemen', 'wirausaha', 'startup', 'umkm', 'marketing']);
    final topMentor = getTopMentor();

    return Scaffold(
      backgroundColor: const Color(0xFFB3E0FF),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppBarUser(userName: widget.userName),
            const SizedBox(height: 24),
            section('Top Mentor', topMentor != null ? [topMentor] : []),
            section('Raja Matematika', rajaMtk),
            section('Jago Ngoding', jagoNgoding),
            section('Pebisnis', pebisnis),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavUser(
        currentIndex: 0, 
        userName: widget.userName, 
      ),
    );
  }
}