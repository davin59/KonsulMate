import 'package:flutter/material.dart';

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
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers for text fields (optional, but good practice for form handling)
  final TextEditingController _namaLengkapController =
      TextEditingController(text: 'Davin Vergian Rizapratama');
  final TextEditingController _jenisKelaminController =
      TextEditingController(text: 'Laki-laki');
  final TextEditingController _noHpController =
      TextEditingController(text: '081276571881');
  final TextEditingController _asalKampusController =
      TextEditingController(text: 'Universitas Ahmad Dahlan');
  final TextEditingController _prodiController =
      TextEditingController(text: 'Sistem Informasi');
  final TextEditingController _keahlianController =
      TextEditingController(text: 'Frontend Developer,Data Analys, dll');
  final TextEditingController _toolsController =
      TextEditingController(text: 'Ms Word, Javascript, TailWind');
  final TextEditingController _emailController =
      TextEditingController(text: 'Davinvergian01@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '**********');
  final TextEditingController _deskripsiController = TextEditingController(
      text:
          'Bla balabbalabalbalbalblablalblabla\nBla balabbalabalbalbalblablalblabla\nBla balabbalabalbalbalblablalblabla\nBla balabbalabalbalbalblablalblabla\nBla balabbalabalbalbalblablalblabla\nBla balabbalabalbalbalblablalbal');

  bool _obscureText = true; // For password visibility

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
            Navigator.pop(context); // Go back
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
              // Handle Save action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile saved!')),
              );
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
              height: 200, // Height for the blue section
              color: Colors.blue.shade600,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white, // White background for empty avatar
                      child: Icon(
                        Icons.person, // Placeholder icon
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue.shade600, width: 2),
                        ),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.blue.shade600,
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    suffixIcon: Icons.male, // Using male icon, can be gender specific
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
                    suffixIcon: Icons.square_foot_outlined, // Icon for academic hat
                  ),
                  _buildProfileInputField(
                    label: 'Keahlian',
                    controller: _keahlianController,
                    suffixIcon: Icons.workspace_premium_outlined, // Icon for badge/ribbon
                  ),
                  _buildProfileInputField(
                    label: 'Tools yang di kuasai',
                    controller: _toolsController,
                    suffixIcon: Icons.build_outlined, // Wrench icon
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
                    suffixIcon: _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    onSuffixIconPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  _buildProfileInputField(
                    label: 'Deskripsi Singkat',
                    controller: _deskripsiController,
                    maxLines: 7, // Adjust based on expected text length
                    suffixIcon: Icons.description_outlined, // File/description icon
                  ),
                  const SizedBox(height: 30),
                  // Log Out Button
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7, // Adjust width as needed
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle Log Out action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logging out...')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  // Helper Widget for consistent input field styling
  Widget _buildProfileInputField({
    required String label,
    required TextEditingController controller,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLines = 1,
    VoidCallback? onSuffixIconPressed, // For toggling password visibility
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Space between fields
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
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: Icon(suffixIcon, color: Colors.black54),
                      onPressed: onSuffixIconPressed, // Use the provided callback
                    )
                  : null,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            ),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}