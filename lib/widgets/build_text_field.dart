import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcare_app/providers/dokter_provider.dart';
import 'package:quickcare_app/utils/validate.dart';
import '../providers/input_provider.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? icon;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final InputProvider inputProvider =
        Provider.of<InputProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            prefixIcon: icon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: (value) async {
            if (label == 'Pencarian') {
              Provider.of<DokterProvider>(context, listen: false)
                  .searchDokter(value);
            }
            dynamic result;
            try {
              switch (label) {
                case 'Nama Lengkap':
                  result = await Validate.namaValidation(nama: value);
                  result == null
                      ? inputProvider.setErrorMassageNama(null)
                      : null;
                  break;
                case 'NIK':
                  result = await Validate.nikValidation(nik: value);
                  result == null
                      ? inputProvider.setErrorMassageNik(null)
                      : null;
                  break;
                case 'No Handphone':
                  result =
                      await Validate.noHandphoneValidation(noHandphone: value);
                  result == null
                      ? inputProvider.setErrorMassageNoHandphone(null)
                      : null;
                  break;
                case 'Email':
                  result = await Validate.emailValidation(email: value);
                  result == null
                      ? inputProvider.setErrorMassageEmail(null)
                      : null;
                  break;
                case 'Password':
                  result = await Validate.passwordValidation(password: value);
                  result == null
                      ? inputProvider.setErrorMassagePassword(null)
                      : null;
                  break;
                default:
                  result = null;
                  break;
              }
            } catch (e) {
              switch (label) {
                case 'Nama Lengkap':
                  inputProvider.setErrorMassageNama(e.toString());
                  break;
                case 'NIK':
                  inputProvider.setErrorMassageNik(e.toString());
                  break;
                case 'No Handphone':
                  inputProvider.setErrorMassageNoHandphone(e.toString());
                  break;
                case 'Email':
                  inputProvider.setErrorMassageEmail(e.toString());
                  break;
                case 'Password':
                  inputProvider.setErrorMassagePassword(e.toString());
                  break;
                default:
                  break;
              }
            }
          },
        ),
      ],
    );
  }
}
