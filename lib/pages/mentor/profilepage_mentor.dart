import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? mentorData; // Tambahan: menerima data mentor
  const EditProfileScreen({super.key, this.mentorData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _asalKampusController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _keahlianController = TextEditingController();
  final TextEditingController _toolsController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (widget.mentorData != null) {
      _setMentorData(widget.mentorData!);
    } else {
      _loadMentorData();
    }
  }

  void _setMentorData(Map<String, dynamic> mentor) {
    _namaLengkapController.text = mentor['nama'] ?? '';
    _jenisKelaminController.text = mentor['jenis_kelamin'] ?? '';
    _noHpController.text = mentor['no_hp'] ?? '';
    _asalKampusController.text = mentor['asal_kampus'] ?? '';
    _prodiController.text = mentor['prodi'] ?? '';
    _keahlianController.text = mentor['keahlian'] ?? '';
    _toolsController.text = mentor['tools'] ?? '';
    _emailController.text = mentor['email'] ?? '';
    _passwordController.text = mentor['password'] ?? '';
    _deskripsiController.text = mentor['deskripsi'] ?? '';
  }

  Future<void> _loadMentorData() async {
    final String data = await rootBundle.loadString('assets/data/dummy.json');
    final jsonData = json.decode(data);
    final List mentors = jsonData['mentor'];
    final mentor = mentors.firstWhere(
      (m) => m['id'] == 'm1',
      orElse: () => null,
    );

    if (mentor != null) {
      setState(() {
        _namaLengkapController.text = mentor['nama'] ?? '';
        _jenisKelaminController.text = mentor['jenis_kelamin'] ?? '';
        _noHpController.text = mentor['no_hp'] ?? '';
        _asalKampusController.text = mentor['asal_kampus'] ?? '';
        _prodiController.text = mentor['prodi'] ?? '';
        _keahlianController.text = mentor['keahlian'] ?? '';
        _toolsController.text = mentor['tools'] ?? '';
        _emailController.text = mentor['email'] ?? '';
        _passwordController.text = mentor['password'] ?? '';
        _deskripsiController.text = mentor['deskripsi'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _jenisKelaminController.dispose();
    _noHpController.dispose();
    _asalKampusController.dispose();
    _prodiController.dispose();
    _keahlianController.dispose();
    _toolsController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Profile saved!')));
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture Section
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blue.shade600,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 80, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Profile Details Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileInputField(
                    label: 'Nama Lengkap',
                    controller: _namaLengkapController,
                    suffixIcon: Icons.person_outline,
                  ),
                  _buildProfileInputField(
                    label: 'Jenis Kelamin',
                    controller: _jenisKelaminController,
                    suffixIcon: Icons.male,
                  ),
                  _buildProfileInputField(
                    label: 'No Hp',
                    controller: _noHpController,
                    suffixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildProfileInputField(
                    label: 'Asal Kampus',
                    controller: _asalKampusController,
                    suffixIcon: Icons.school_outlined,
                  ),
                  _buildProfileInputField(
                    label: 'Prodi',
                    controller: _prodiController,
                    suffixIcon: Icons.square_foot_outlined,
                  ),
                  _buildProfileInputField(
                    label: 'Keahlian',
                    controller: _keahlianController,
                    suffixIcon: Icons.workspace_premium_outlined,
                  ),
                  _buildProfileInputField(
                    label: 'Tools yang di kuasai',
                    controller: _toolsController,
                    suffixIcon: Icons.build_outlined,
                  ),
                  _buildProfileInputField(
                    label: 'Email',
                    controller: _emailController,
                    suffixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildProfileInputField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: _obscureText,
                    suffixIcon:
                        _obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                    onSuffixIconPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  _buildProfileInputField(
                    label: 'Deskripsi Singkat',
                    controller: _deskripsiController,
                    maxLines: 7,
                    suffixIcon: Icons.description_outlined,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logging out...')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInputField({
    required String label,
    required TextEditingController controller,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLines = 1,
    VoidCallback? onSuffixIconPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              suffixIcon:
                  suffixIcon != null
                      ? IconButton(
                        icon: Icon(suffixIcon, color: Colors.black54),
                        onPressed: onSuffixIconPressed,
                      )
                      : null,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
            ),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
