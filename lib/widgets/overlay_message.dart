import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverlayMessage {
  bool _isVisible = false;

  void showOverlayMessage(BuildContext context, String message, {Color color = Colors.red}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 50.0, // Atur posisi vertikal sesuai kebutuhan
          left:
              MediaQuery.of(context).size.width * 0.1, // Atur posisi horizontal
          right: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            color: Colors.transparent,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: GoogleFonts.notoSansCaucasianAlbanian(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );

    // Menambahkan overlay entry ke overlay
    overlay.insert(overlayEntry);

    // Menampilkan pesan
    Future.delayed(const Duration(milliseconds: 100), () {
      // Mengubah state untuk memunculkan animasi
      _isVisible = true;
      overlayEntry.markNeedsBuild(); // Memperbarui overlay entry
    });

    // Mengatur opacity menjadi 0 setelah beberapa detik untuk menghilangkan pesan
    Future.delayed(const Duration(seconds: 2), () {
      _isVisible = false; // Mengubah state untuk menghilangkan animasi
      overlayEntry.markNeedsBuild(); // Memperbarui overlay entry

      // Menghapus overlay entry setelah animasi menghilang
      Future.delayed(const Duration(milliseconds: 300), () {
        overlayEntry.remove(); // Menghapus overlay entry
      });
    });
  }
}