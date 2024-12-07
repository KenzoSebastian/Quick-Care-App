import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatefulWidget {
  const MyButton(
      {super.key, this.margin, required this.text, this.onPressed, this.color});

  final EdgeInsetsGeometry? margin;
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late Color buttonColor;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.color == null) {
      setState(() {
        buttonColor = Theme.of(context).secondaryHeaderColor;
      });
    } else {
      setState(() {
        buttonColor = widget.color!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 45),
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
