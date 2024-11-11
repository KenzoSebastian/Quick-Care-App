import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './login_page.dart';
import '../widgets/build_text_field.dart';
import '../providers/register_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;

    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController nikController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController birthDateController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Silakan masukkan informasi Anda untuk mendaftar.",
              style: GoogleFonts.poppins(fontSize: screenSize.width * 0.04),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Full Name Field
            BuildTextField(
              controller: fullNameController,
              label: 'Nama Lengkap',
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            // NIK Field
            BuildTextField(
              controller: nikController,
              label: 'NIK',
              icon: Icons.credit_card,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Phone Number Field
            BuildTextField(
              controller: phoneController,
              label: 'No Handphone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            // Birth Date Field
            BuildTextField(
              controller: birthDateController,
              label: 'Tanggal Lahir',
              icon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            // Email Field
            BuildTextField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Password Field
            Consumer<RegisterProvider>(
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah punya akun?",
                    style: GoogleFonts.poppins(
                        fontSize: screenSize.width * 0.035)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LoginPage.routeName);
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
            SizedBox(height: availableHeight * 0.06),
            SizedBox(
              width: screenSize.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  // Implement registration functionality here
                  // You can access the text from the controllers
                  // Example: print(fullNameController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child:
                    const Text('Daftar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
