import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyValue extends StatelessWidget {
  const KeyValue({super.key, required this.width, required this.keyword, required this.value});
  final double width;
  final String keyword;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        width: width * .38,
        child: Text(
          keyword,
          style: GoogleFonts.ptSans(
            fontSize: width * .04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text(
        ':  ',
        style: GoogleFonts.ptSans(
          fontSize: width * .04,
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: GoogleFonts.ptSans(
            fontSize: width * .04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]);
  }
}
