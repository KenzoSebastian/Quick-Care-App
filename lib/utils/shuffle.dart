import 'dart:math';

class Shuffle {
  static List<T> shuffle<T>(List<T> list) {
    final random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1); // Menghasilkan indeks acak
      // Tukar elemen
      final temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
    return list; // Mengembalikan daftar yang sudah diacak
  }
}
