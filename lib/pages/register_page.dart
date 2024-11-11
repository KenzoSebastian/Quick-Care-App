import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/animate_fade.dart';
import './login_page.dart';
import '../widgets/build_text_field.dart';
import '../providers/register_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
      setState(() => birthDateController.text = formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const AnimatedFade(delay: 200, child: Text('Daftar')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            AnimatedFade(
              delay: 400,
              child: Text(
                "Silakan masukkan informasi Anda untuk mendaftar.",
                style: GoogleFonts.poppins(fontSize: screenSize.width * 0.04),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Full Name Field
            AnimatedFade(
              delay: 600,
              child: BuildTextField(
                controller: fullNameController,
                label: 'Nama Lengkap',
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 20),
            // NIK Field
            AnimatedFade(
              delay: 800,
              child: BuildTextField(
                controller: nikController,
                label: 'NIK',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),
            // Phone Number Field
            AnimatedFade(
              delay: 1000,
              child: BuildTextField(
                controller: phoneController,
                label: 'No Handphone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 20),
            // Birth Date Field
            AnimatedFade(
              delay: 1200,
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                  print('Birth Date Field Tapped'); // Debugging
                },
                child: AbsorbPointer(
                  child: BuildTextField(
                    controller: birthDateController,
                    label: 'Tanggal Lahir',
                    icon: Icons.calendar_today,
                    readOnly: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email Field
            AnimatedFade(
              delay: 1400,
              child: BuildTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20),
            // Password Field
            AnimatedFade(
              delay: 1600,
              child: Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) => BuildTextField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: registerProvider.hidePass,
                  suffixIcon: IconButton(
                    onPressed: () {
                      registerProvider.setHidePass();
                    },
                    icon: registerProvider.hidePass
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedFade(
              delay: 1800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun?",
                      style: GoogleFonts.poppins(
                          fontSize: screenSize.width * 0.035)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginPage.routeName);
                    },
                    child: Text("Login",
                        style: GoogleFonts.poppins(
                          fontSize: screenSize.width * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).secondaryHeaderColor,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: availableHeight * 0.06),
            AnimatedFade(
              delay: 2000,
              child: SizedBox(
                width: screenSize.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    print(birthDateController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Daftar',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    nikController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
