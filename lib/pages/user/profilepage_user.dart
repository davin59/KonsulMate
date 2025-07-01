import 'package:flutter/material.dart';
import 'homepage_user.dart'; // pastikan path ini sesuai struktur project Anda

void main() {
  runApp(const UserProfilePage());
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
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
  // Provided data (extended to include new fields)
  String fullName = "Davin Vergian Rizapratama";
  String gender = "Laki-laki";
  String phoneNumber = "081276571881";
  String originCampus = "Universitas Ahmad Dahlan";
  String major = "Sistem Informasi";
  String expertise = "Frontend Developer,Data Analys, dll";
  String toolsMastered = "Ms Word, Javascript, TailWind"; // New field
  String email = "Davinvergian01@gmail.com"; // New field
  String password = "***********"; // New field (obscured)
  String shortDescription =
      "Bla balabbalabalbalbalbalbalblablablabla\n"
      "Bla balabbalabalbalbalbalbalblablablabla\n"
      "Bla balabbalabalbalbalbalbalblablablabla\n"
      "Bla balabbalabalbalbalbalbalblablablabla\n"
      "Bla balabbalabalbalbalbalbalblablablabla\n"
      "Bla balabbalabalbalbalbal"; // New field

  // Controllers for potential editing
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _campusController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _toolsController =
      TextEditingController(); // New controller
  final TextEditingController _emailController =
      TextEditingController(); // New controller
  final TextEditingController _passwordController =
      TextEditingController(); // New controller
  final TextEditingController _descriptionController =
      TextEditingController(); // New controller

  bool _isPasswordVisible = false; // For the password field eye icon

  @override
  void initState() {
    super.initState();
    _fullNameController.text = fullName;
    _genderController.text = gender;
    _phoneController.text = phoneNumber;
    _campusController.text = originCampus;
    _majorController.text = major;
    _expertiseController.text = expertise;
    _toolsController.text = toolsMastered; // Initialize new controller
    _emailController.text = email; // Initialize new controller
    _passwordController.text = password; // Initialize new controller
    _descriptionController.text = shortDescription; // Initialize new controller
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _campusController.dispose();
    _majorController.dispose();
    _expertiseController.dispose();
    _toolsController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _buildProfileField({
    required String label,
    required String value,
    required IconData icon,
    TextEditingController? controller,
    bool readOnly = true,
    VoidCallback? onTap,
    bool isPassword = false,
    int? maxLines = 1, // Ubah dari int maxLines = 1 menjadi int? maxLines = 1
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: onTap,
            child: AbsorbPointer(
              absorbing: readOnly,
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                obscureText: isPassword && !_isPasswordVisible,
                maxLines: maxLines, // Set maxLines for description field
                decoration: InputDecoration(
                  suffixIcon:
                      isPassword
                          ? IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          )
                          : Icon(icon, color: Colors.black54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: value,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Blue Header with Profile Picture and App Bar elements
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                color: Colors.lightBlue,
                child: Stack(
                  children: [
                    // App Bar elements
                    Positioned(
                      top: 40,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => HomeUser(
                                        userName:
                                            "Nama User", // ganti sesuai kebutuhan
                                        userId:
                                            "user_id", // ganti sesuai kebutuhan
                                      ),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Save profile logic
                              ('Save button pressed');
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Profile Picture
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile_pic.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child:
                                  (const AssetImage('assets/profile_pic.jpg') ==
                                          null)
                                      ? const Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.white,
                                      )
                                      : null,
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileField(
                        label: 'Nama Lengkap',
                        value: fullName,
                        icon: Icons.person_outline,
                        controller: _fullNameController,
                        readOnly: false, // Make this editable
                      ),
                      _buildProfileField(
                        label: 'Jenis Kelamin',
                        value: gender,
                        icon: Icons.male,
                        controller: _genderController,
                        onTap: () {
                          // Implement gender selection (e.g., show dropdown/modal)
                          ('Gender field tapped for selection!');
                        },
                      ),
                      _buildProfileField(
                        label: 'No Hp',
                        value: phoneNumber,
                        icon: Icons.call,
                        controller: _phoneController,
                        readOnly: false,
                      ),
                      _buildProfileField(
                        label: 'Asal Kampus',
                        value: originCampus,
                        icon: Icons.house_outlined,
                        controller: _campusController,
                        readOnly: false,
                      ),
                      _buildProfileField(
                        label: 'Prodi',
                        value: major,
                        icon: Icons.school,
                        controller: _majorController,
                        readOnly: false,
                      ),
                      _buildProfileField(
                        label: 'Keahlian',
                        value: expertise,
                        icon: Icons.military_tech,
                        controller: _expertiseController,
                        readOnly: false,
                      ),
                      // New fields to be displayed on scroll
                      _buildProfileField(
                        label: 'Tools yang di kuasai',
                        value: toolsMastered,
                        icon: Icons.build,
                        controller: _toolsController,
                        readOnly: false,
                      ),
                      _buildProfileField(
                        label: 'Email',
                        value: email,
                        icon: Icons.mail_outline, // Adjusted icon
                        controller: _emailController,
                        readOnly: false,
                      ),
                      _buildProfileField(
                        label: 'Password',
                        value: password,
                        icon: Icons.remove_red_eye_outlined,
                        controller: _passwordController,
                        isPassword: true, // Mark as password field
                        readOnly: false,
                      ),
                      _buildProfileField(
                        label: 'Deskripsi Singkat',
                        value: shortDescription,
                        icon: Icons.description,
                        controller: _descriptionController,
                        readOnly: false,
                        maxLines: null, // Allow unlimited lines for description
                      ),
                      const SizedBox(
                        height: 80,
                      ), // beri ruang untuk sticky button
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Sticky Log Out Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  width: double.infinity,
                  child: SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {
                        // Log Out logic
                        ('Log Out button pressed!');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.red),
                        ),
                        elevation: 2,
                        minimumSize: const Size(0, 36),
                        maximumSize: const Size(double.infinity, 36),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
