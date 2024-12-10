import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/widgets/overlay_message.dart';
import '../providers/dashboard_provider.dart';
import '../providers/input_provider.dart';
import '../utils/load_all_data.dart';
import '../widgets/build_text_field.dart';
import '../widgets/animate_fade.dart';
import '../widgets/button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const routeName = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController namaController = TextEditingController(),
      nikController = TextEditingController(),
      noHpController = TextEditingController(),
      tglLahirController = TextEditingController();
  bool _errorInitialNull = false;
  bool _initialData = false;
  late DateTime initialDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      initialDate = pickedDate;
      String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);
      setState(() => tglLahirController.text = formattedDate);
    }
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final InputProvider inputProvider =
          Provider.of<InputProvider>(context, listen: false);
      if (!_errorInitialNull) {
        inputProvider.setErrorMassageNama(null);
        inputProvider.setErrorMassageNik(null);
        inputProvider.setErrorMassageNoHandphone(null);
        inputProvider.setErrorMassageEmail(null);
        inputProvider.setErrorMassagePassword(null);
        _errorInitialNull = true;
      }
      if (_initialData) return;
      var data = Provider.of<LoadDataUser>(context, listen: false).data;
      namaController.text = data['nama'] == null ? '' : '${data['nama']}';
      nikController.text = data['nik'] == null ? '' : '${data['nik']}';
      noHpController.text =
          data['no_handphone'] == null ? '' : '0${data['no_handphone']}';
      tglLahirController.text =
          data['tanggal_lahir'] == null ? '' : '${data['tanggal_lahir']}';
      initialDate = data['tanggal_lahir'] == null
          ? DateTime.now()
          : DateTime.parse(data['tanggal_lahir']);
      _initialData = true;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarHeight = AppBar().preferredSize.height;
    final double availableHeight = screenSize.height - appBarHeight;
    return Scaffold(
      appBar: AppBar(
        title: const AnimatedFade(delay: 50, child: Text('Edit Profile')),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * .05),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: availableHeight * .035),
                    child: AnimatedFade(
                      delay: 200,
                      child: Image.asset('assets/images/edit.png',
                          height: screenSize.height * 0.25),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .01),
                  AnimatedFade(
                    delay: 400,
                    child: Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: screenSize.width * .06,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: availableHeight * .05),
                  AnimatedFade(
                    delay: 600,
                    child: Column(
                      children: [
                        BuildTextField(
                          controller: namaController,
                          label: 'Nama Lengkap',
                          icon: const Icon(Icons.person),
                        ),
                        Consumer<InputProvider>(
                          builder: (context, value, child) {
                            if (value.errorMassageNama == null ||
                                namaController.text.isEmpty) {
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
                                    style: const TextStyle(color: Colors.red)),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: availableHeight * .025),
                  AnimatedFade(
                    delay: 800,
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
                                    style: const TextStyle(color: Colors.red)),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: availableHeight * .025),
                  AnimatedFade(
                    delay: 1000,
                    child: Column(
                      children: [
                        BuildTextField(
                          controller: noHpController,
                          label: 'No Handphone',
                          icon: const Icon(Icons.phone),
                          keyboardType: TextInputType.phone,
                        ),
                        Consumer<InputProvider>(
                          builder: (context, value, child) {
                            if (value.errorMassageNoHandphone == null ||
                                noHpController.text.isEmpty) {
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
                                    style: const TextStyle(color: Colors.red)),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: availableHeight * .025),
                  AnimatedFade(
                    delay: 1200,
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: AbsorbPointer(
                        child: BuildTextField(
                          controller: tglLahirController,
                          label: 'Tanggal Lahir',
                          icon: const Icon(Icons.calendar_today),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedFade(
              delay: 1400,
              child: SizedBox(
                width: screenSize.width * 0.9,
                child: Consumer<LoadDataUser>(
                  builder: (context, provider, child) => MyButton(
                    text: 'Edit Profile',
                    margin: EdgeInsets.only(bottom: screenSize.height * .03),
                    onPressed: () async {
                      await provider.editUser(
                          nama: namaController.text,
                          nik: nikController.text,
                          noHandphone: noHpController.text,
                          tglLahir: tglLahirController.text);
                      if (provider.statusEditUser['status'] == 404) {
                        OverlayMessage().showOverlayMessage(
                            context, provider.statusEditUser['error']);
                        return;
                      }
                      Navigator.pop(context);
                      await LoadAllData.loadProfilePage(context);
                      OverlayMessage().showOverlayMessage(
                          context, "Profile berhasil di edit");
                    },
                  ),
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
    namaController.dispose();
    nikController.dispose();
    noHpController.dispose();
    tglLahirController.dispose();
    super.dispose();
  }
}
