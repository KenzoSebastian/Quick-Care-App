import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/widgets/bottom_navbar.dart';
import 'package:quickcare_app/widgets/button.dart';
import 'package:quickcare_app/widgets/overlay_message.dart';
import '../providers/input_provider.dart';
import '../widgets/animate_fade.dart';
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
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  bool _errorInitialNull = false;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final InputProvider inputProvider =
          Provider.of<InputProvider>(context, listen: false);
      if (!inputProvider.hidePass) {
        inputProvider.setHidePass();
      }
      if (!_errorInitialNull) {
        inputProvider.setErrorMassageEmail(null);
        inputProvider.setErrorMassagePassword(null);
        _errorInitialNull = true;
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: screenSize.height * .03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedFade(
                        delay: 200,
                        child: Image.asset('assets/images/login.jpg',
                            height: screenSize.height * 0.3),
                      ),
                      const SizedBox(height: 10),
                      AnimatedFade(
                        delay: 400,
                        child: Text(
                          "Silakan masukkan email dan kata sandi Anda untuk melanjutkan.",
                          style: GoogleFonts.poppins(
                              fontSize: screenSize.width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedFade(
                        delay: 600,
                        child: Column(
                          children: [
                            BuildTextField(
                              controller: emailController,
                              label: 'Email',
                              icon: const Icon(Icons.email),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Consumer<InputProvider>(
                              builder: (context, value, child) {
                                if (value.errorMassageEmail == null ||
                                    emailController.text.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(value.errorMassageEmail ?? '',
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedFade(
                        delay: 800,
                        child: Consumer<InputProvider>(
                          builder: (context, provider, child) => Column(
                            children: [
                              BuildTextField(
                                controller: passwordController,
                                label: 'Password',
                                icon: const Icon(Icons.lock),
                                obscureText: provider.hidePass,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    provider.setHidePass();
                                  },
                                  icon: provider.hidePass
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                              Consumer<InputProvider>(
                                builder: (context, value, child) {
                                  if (value.errorMassagePassword == null ||
                                      passwordController.text.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(value.errorMassagePassword ?? '',
                                          style: const TextStyle(
                                              color: Colors.red)),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedFade(
                        delay: 1000,
                        child: Row(
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
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedFade(
                delay: 1200,
                child: Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) => MyButton(
                    text: "Login",
                    margin: const EdgeInsets.only(bottom: 20),
                    onPressed: () async {
                      await loginProvider.loginUser(
                          email: emailController.text,
                          password: passwordController.text);
                      if (loginProvider.user['error'] == null) {
                        Navigator.pushReplacementNamed(
                            context, BottomNavbar.routeName,
                            arguments: loginProvider.user);
                      } else {
                        OverlayMessage().showOverlayMessage(
                            context, loginProvider.user['error']);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
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
