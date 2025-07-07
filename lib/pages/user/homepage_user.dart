// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../widgets/appbar_user.dart';
import '../widgets/footer_user.dart';
import '../widgets/mentor_section.dart';
import 'mentor_detail_page.dart';
import '../widgets/search_bar.dart';
import '../widgets/iklan.dart';

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

  // Tambahkan metode navigasi
  void _navigateToMentorDetail(String mentorId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MentorDetailPage(
          mentorId: mentorId,
          userId: widget.userId,
          userName: widget.userName,
          asalKampus: widget.asalKampus,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBarUser(
            userName: widget.userName,
            userId: widget.userId,
            asalKampus: widget.asalKampus,
          ),
          
          // Tambahkan SearchBar di sini
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: CustomSearchBar(
              userName: widget.userName,
              userId: widget.userId,
            ),
          ),

          // Tambahkan iklan di bawah search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: IklanPage(),
          ),
          
          // Top Mentors
          MentorSection(
            title: 'Top Mentor',
            onMentorTap: _navigateToMentorDetail,
          ),
          
          // Raja Matematika - hapus const
          FilteredMentorSection(
            title: 'Raja Matematika',
            keywords: ['matematika', 'kalkulus', 'statistik'],
            onMentorTap: _navigateToMentorDetail,
          ),
          
          // Jago Ngoding - hapus const
          FilteredMentorSection(
            title: 'Jago Ngoding',
            keywords: ['programming', 'web', 'android', 'informatika'],
            onMentorTap: _navigateToMentorDetail,
          ),
          
          // Pebisnis - hapus const
          FilteredMentorSection(
            title: 'Pebisnis',
            keywords: ['bisnis', 'manajemen', 'wirausaha'],
            onMentorTap: _navigateToMentorDetail,
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

// Tambahkan widget helper untuk menampilkan iklan tanpa AppBar
class IklanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/iklan/iklan2.jpg',
      'assets/iklan/iklan3.jpg',
    ];
    return SizedBox(
      height: 220, // Tinggi diperbesar agar gambar proporsional
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.92, // Lebar hampir penuh layar
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.contain, // Gambar tampil penuh tanpa terpotong
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}