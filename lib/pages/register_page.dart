import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/widgets/button.dart';
import 'package:quickcare_app/widgets/overlay_message.dart';
import '../providers/input_provider.dart';
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
  final TextEditingController fullNameController = TextEditingController(),
      nikController = TextEditingController(),
      phoneController = TextEditingController(),
      birthDateController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();
  bool _errorInitialNull = false;

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
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final InputProvider inputProvider =
          Provider.of<InputProvider>(context, listen: false);
      if (!inputProvider.hidePass) {
        inputProvider.setHidePass();
      }
      if (!_errorInitialNull) {
        inputProvider.setErrorMassageNama(null);
        inputProvider.setErrorMassageNik(null);
        inputProvider.setErrorMassageNoHandphone(null);
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
                        child: Text(
                          "Silakan masukkan informasi Anda untuk mendaftar.",
                          style: GoogleFonts.poppins(
                              fontSize: screenSize.width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenSize.height * .04),
                      AnimatedFade(
                        delay: 400,
                        child: Column(
                          children: [
                            BuildTextField(
                              controller: fullNameController,
                              label: 'Nama Lengkap',
                              icon: const Icon(Icons.person),
                            ),
                            Consumer<InputProvider>(
                              builder: (context, value, child) {
                                if (value.errorMassageNama == null ||
                                    fullNameController.text.isEmpty) {
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
                                    Text(value.errorMassageNama ?? '',
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * .025),
                      AnimatedFade(
                        delay: 600,
                        child: Column(
                          children: [
                            BuildTextField(
                              controller: nikController,
                              label: 'NIK',
                              icon: const Icon(Icons.credit_card),
                              keyboardType: TextInputType.number,
                            ),
                            Consumer<InputProvider>(
                              builder: (context, value, child) {
                                if (value.errorMassageNik == null ||
                                    nikController.text.isEmpty) {
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
                                    Text(value.errorMassageNik ?? '',
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * .025),
                      AnimatedFade(
                        delay: 800,
                        child: Column(
                          children: [
                            BuildTextField(
                              controller: phoneController,
                              label: 'No Handphone',
                              icon: const Icon(Icons.phone),
                              keyboardType: TextInputType.phone,
                            ),
                            Consumer<InputProvider>(
                              builder: (context, value, child) {
                                if (value.errorMassageNoHandphone == null ||
                                    phoneController.text.isEmpty) {
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
                                    Text(value.errorMassageNoHandphone ?? '',
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * .025),
                      AnimatedFade(
                        delay: 1000,
                        child: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: AbsorbPointer(
                            child: BuildTextField(
                              controller: birthDateController,
                              label: 'Tanggal Lahir',
                              icon: const Icon(Icons.calendar_today),
                              readOnly: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * .025),
                      AnimatedFade(
                        delay: 1200,
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
                                if (value.errorMassageEmail == null) {
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
                      SizedBox(height: screenSize.height * .025),
                      AnimatedFade(
                        delay: 1400,
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
                                  if (value.errorMassagePassword == null) {
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
                      SizedBox(height: screenSize.height * .025),
                      AnimatedFade(
                        delay: 1600,
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
                delay: 1800,
                child: SizedBox(
                  width: screenSize.width * 0.9,
                  child: Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) => MyButton(
                      text: 'Daftar',
                      margin: EdgeInsets.only(bottom: screenSize.height * .03),
                      onPressed: () async {
                        await registerProvider.createUser(
                          nama: fullNameController.text,
                          nik: nikController.text,
                          noHandphone: phoneController.text,
                          tglLahir: birthDateController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (registerProvider.user['error'] == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registrasi Berhasil'),
                                content: const Text(
                                    'Anda telah berhasil mendaftar.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacementNamed(
                                          context, LoginPage.routeName);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          OverlayMessage().showOverlayMessage(
                              context, registerProvider.user['error']);
                        }
                      },
                    ),
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
    fullNameController.dispose();
    nikController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
