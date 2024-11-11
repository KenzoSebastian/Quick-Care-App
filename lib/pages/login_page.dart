import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './register_page.dart';
import '../widgets/build_text_field.dart';
import '../providers/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/login.jpg',
                height: availableHeight * 0.3),
            const SizedBox(height: 10),
            Text(
              "Silakan masukkan email dan kata sandi Anda untuk melanjutkan.",
              style: GoogleFonts.poppins(fontSize: screenSize.width * 0.04),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            BuildTextField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            Consumer<LoginProvider>(
              builder: (context, loginProvider, child) => BuildTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: loginProvider.hidePass,
                suffixIcon: IconButton(
                  onPressed: () {
                    loginProvider.setHidePass();
                  },
                  icon: loginProvider.hidePass
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tidak punya akun?",
                    style: GoogleFonts.poppins(
                        fontSize: screenSize.width * 0.035)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterPage.routeName);
                  },
                  child: Text("Daftar",
                      style: GoogleFonts.poppins(
                        fontSize: screenSize.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                      )),
                ),
              ],
            ),
            SizedBox(height: availableHeight * 0.15),
            SizedBox(
              width: screenSize.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child:
                    const Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
