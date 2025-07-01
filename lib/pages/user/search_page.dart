import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/appbar_user.dart';
import '../widgets/footer_user.dart';
import '../widgets/mentor_section.dart';

class SearchPage extends StatefulWidget {
  final String userName;
  final String userId;

  const SearchPage({super.key, required this.userName, required this.userId});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> allMentors = [];
  List<dynamic> filteredMentors = [];
  String activeFilter = 'Semua';
  bool isLoading = true;
  bool showAllFilters = false; // Untuk mengontrol tampilan filter

  // Daftar semua filter yang tersedia
  final List<String> allFilters = [
    'Semua',
    'Matematika',
    'Bisnis',
    'Coding',
    'Manajemen',
    'Ilmu Komputer',
    'Arduino',
    'Ekonomi',
    'Kotlin',
  ];

  // Filter yang ditampilkan secara default
  List<String> get defaultFilters => ['Semua', 'Matematika', 'Bisnis'];

  // Filter yang akan ditampilkan
  List<String> get visibleFilters =>
      showAllFilters ? allFilters : defaultFilters;

  @override
  void initState() {
    super.initState();
    loadMentors();
  }

  Future<void> loadMentors() async {
    try {
      final String data = await rootBundle.loadString('assets/data/dummy.json');
      final jsonData = json.decode(data);

      setState(() {
        allMentors = jsonData['mentor'];
        filteredMentors = allMentors;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading mentor data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterMentors(String query) {
    if (query.isEmpty && activeFilter == 'Semua') {
      setState(() {
        filteredMentors = allMentors;
      });
      return;
    }

    List<dynamic> results = allMentors;

    // Apply search query
    if (query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      results =
          results.where((mentor) {
            final name = mentor['nama'].toString().toLowerCase();
            final expertise = mentor['keahlian'].toString().toLowerCase();
            final campus =
                mentor['asal_kampus_alumni'].toString().toLowerCase();
            final major = mentor['prodi'].toString().toLowerCase();

            return name.contains(lowercaseQuery) ||
                expertise.contains(lowercaseQuery) ||
                campus.contains(lowercaseQuery) ||
                major.contains(lowercaseQuery);
          }).toList();
    }

    // Apply category filter
    if (activeFilter != 'Semua') {
      results =
          results.where((mentor) {
            final expertise = mentor['keahlian'].toString().toLowerCase();
            final major = mentor['prodi'].toString().toLowerCase();
            final tools = mentor['tools_disukai'].toString().toLowerCase();

            switch (activeFilter) {
              case 'Matematika':
                return expertise.contains('matematika') ||
                    expertise.contains('statistik') ||
                    expertise.contains('kalkulus') ||
                    major.contains('matematika');
              case 'Bisnis':
                return expertise.contains('bisnis') ||
                    major.contains('bisnis') ||
                    expertise.contains('startup');
              case 'Coding':
                return expertise.contains('coding') ||
                    expertise.contains('programming') ||
                    expertise.contains('development');
              case 'Manajemen':
                return expertise.contains('manajemen') ||
                    major.contains('manajemen');
              case 'Ilmu Komputer':
                return major.contains('ilmu komputer') ||
                    major.contains('informatika');
              case 'Arduino':
                return expertise.contains('arduino') ||
                    expertise.contains('iot') ||
                    tools.contains('arduino');
              case 'Ekonomi':
                return major.contains('ekonomi') ||
                    expertise.contains('ekonomi') ||
                    expertise.contains('keuangan');
              case 'Kotlin':
                return expertise.contains('kotlin') ||
                    expertise.contains('android') ||
                    tools.contains('kotlin');
              default:
                return false;
            }
          }).toList();
    }

    setState(() {
      filteredMentors = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB), // putih pudar
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            AppBarUser(userName: widget.userName),

            // Search input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Cari mentor...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        onChanged: (value) {
                          filterMentors(value);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      showAllFilters
                          ? Icons.filter_list_off
                          : Icons.filter_list,
                      color: Colors.blue[700],
                    ),
                    onPressed: () {
                      setState(() {
                        showAllFilters = !showAllFilters;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children:
                    visibleFilters
                        .map((filter) => _buildFilterChip(filter))
                        .toList(),
              ),
            ),

            const SizedBox(height: 8),

            // Mentor grid
            if (isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (filteredMentors.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Tidak ada mentor yang sesuai dengan pencarian',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredMentors.length,
                  itemBuilder: (context, index) {
                    return MentorCard(
                      mentor: filteredMentors[index],
                      onTap: () {
                        // Navigate to mentor detail page
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: FooterUser(
        currentIndex: 2,
        userName: widget.userName,
        userId: widget.userId,
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isActive = activeFilter == label;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            activeFilter = label;
            filterMentors(searchController.text);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.blue : Colors.blue.shade200,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Text(label),
      ),
    );
  }
}
