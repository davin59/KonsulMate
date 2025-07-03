// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/mentor_card.dart';
import '../widgets/footer_user.dart';

class MentorDetailPage extends StatefulWidget {
  final String mentorId;
  final String userId;
  final String userName;
  final String asalKampus;

  const MentorDetailPage({
    super.key,
    required this.mentorId,
    required this.userId,
    required this.userName,
    this.asalKampus = "",
  });

  @override
  State<MentorDetailPage> createState() => _MentorDetailPageState();
}

class _MentorDetailPageState extends State<MentorDetailPage> {
  bool isLoading = true;
  Map<String, dynamic> mentorData = {};

  @override
  void initState() {
    super.initState();
    _loadMentorData();
  }

  Future<void> _loadMentorData() async {
    setState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot mentorDoc = await FirebaseFirestore.instance
          .collection('mentors')
          .doc(widget.mentorId)
          .get();

      if (mentorDoc.exists) {
        setState(() {
          mentorData = mentorDoc.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mentor tidak ditemukan')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: MentorDetailCard(
                mentorName: mentorData['nama_lengkap'] ?? 'Nama Mentor',
                mentorImageUrl: mentorData['foto_profil'] ?? '',
                expertise: mentorData['prodi'] ?? 'Tidak ada data',
                pricePerHour: mentorData['tarif_per_jam'] ?? 0,
                skills: List<String>.from(mentorData['keahlian']?.split(',') ?? []),
                technologies: List<String>.from(mentorData['teknologi']?.split(',') ?? []),
                university: mentorData['asal_kampus'] ?? 'Tidak ada data',
                rating: (mentorData['rating'] ?? 0).toDouble(),
                orderCount: mentorData['jumlah_order'] ?? 0,
                about: mentorData['tentang'] ?? 'Tidak ada deskripsi',
              ),
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