import 'package:flutter/material.dart';

import 'package:islamic_plus/data/ayat_data.dart';

class SuratUtils {
  static AyatData removeBasmallah(AyatData ayatData) {
    switch (ayatData.number) {
      case 1:
      case 9:
        return ayatData;
      default:
        if (ayatData.numberInSurah == 1) {
          var text = ayatData.text.substring(39);
          return AyatData(
            number: ayatData.number,
            text: text,
            numberInSurah: ayatData.numberInSurah,
            juz: ayatData.juz,
            sajda: ayatData.sajda,
            translate: ayatData.translate,
          );
        } else {
          return ayatData;
        }
    }
  }

  static String convertToArabicNumber(String number) {
    String res = '';

    final arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var element in number.characters) {
      res += arabicNumbers[int.parse(element)];
    }

    return res;
  }
}
