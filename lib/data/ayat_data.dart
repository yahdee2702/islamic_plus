import 'package:islamic_plus/data/sajda_data.dart';

class AyatData {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final SajdaData sajda;
  String? translate;

  AyatData({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.sajda,
    this.translate,
  });

  factory AyatData.fromJSON(Map<String, dynamic> theJson) {
    return AyatData(
      number: theJson['number'],
      text: theJson['text'],
      numberInSurah: theJson['numberInSurah'],
      juz: theJson['juz'],
      sajda: SajdaData.fromJSON(theJson['sajda']),
    );
  }
}
