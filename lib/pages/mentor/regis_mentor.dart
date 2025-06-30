import 'package:flutter/material.dart';

void main() {
  runApp(const RegisMentor());
}

class RegisMentor extends StatelessWidget {
  const RegisMentor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Sebagai Mentor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegisterMentorScreen(),
    );
  }
}

class RegisterMentorScreen extends StatefulWidget {
  const RegisterMentorScreen({super.key});

  @override
  State<RegisterMentorScreen> createState() => _RegisterMentorScreenState();
}

class _RegisterMentorScreenState extends State<RegisterMentorScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _campusController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _toolsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _campusController.dispose();
    _majorController.dispose();
    _expertiseController.dispose();
    _toolsController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildInputField(
      TextEditingController controller, String labelText, IconData icon,
      {bool isPassword = false, int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // Remove border
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.blue), // Icon on the left
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }

  // A specific input field builder for the gender field,
  // since it requires a different icon and potentially a dropdown/selection logic.
  Widget _buildGenderInputField(TextEditingController controller, String labelText, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true, // Make it read-only to simulate a dropdown
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.blue),
          suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.blue), // Example for a dropdown
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        onTap: () {
          // Implement gender selection logic here (e.g., show a dialog or bottom sheet)
          ('Gender field tapped!');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Sebagai Mentor',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // Allow content to go behind the app bar
      body: Stack(
        children: [
          // Background wave/liquid pattern at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF88D4EE), // Light blue
                      Color(0xFF3399FF), // Brighter blue
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80), // Space for the app bar
                // Profile Picture Placeholder
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFADD8E6), // Light blue for the circle
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildInputField(_fullNameController, 'Nama Lengkap', Icons.person_outline),
                _buildGenderInputField(_genderController, 'Jenis Kelamin', Icons.male),
                _buildInputField(_phoneController, 'No Hp', Icons.call),
                _buildInputField(_campusController, 'Kampus/Alumni', Icons.house_outlined),
                _buildInputField(_majorController, 'Prodi', Icons.school),
                _buildInputField(_expertiseController, 'Keahlian', Icons.military_tech),
                _buildInputField(_toolsController, 'Tools yang di kuasai', Icons.build),
                _buildInputField(_descriptionController, 'Deskripsi Singkat', Icons.description, maxLines: 3),
                _buildInputField(_emailController, 'Email', Icons.email),
                _buildInputField(_passwordController, 'Password', Icons.remove_red_eye_outlined, isPassword: true),
                _buildInputField(_confirmPasswordController, 'Konfirmasi Password', Icons.remove_red_eye_outlined, isPassword: true),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement registration logic here
                      ('Register button pressed!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Extra space at the bottom to avoid overlap with wave
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the wave/liquid background
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.7); // Start from bottom-left, up a bit
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height * 0.8);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height * 0.6);
    var secondEndPoint = Offset(size.width, size.height * 0.9);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Line to top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}