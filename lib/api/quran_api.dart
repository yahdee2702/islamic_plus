import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:islamic_plus/data/ayat_data.dart';
import 'package:islamic_plus/data/surat_data.dart';

class QuranAPI {
  static Future<List<SuratData>> getAllSurah() async {
    try {
      final response = await http.get(
        Uri.parse("http://api.alquran.cloud/v1/surah"),
      );

      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      final List<SuratData> finalResult = [];

      for (var element in data) {
        finalResult.add(SuratData.fromJSON(element));
      }

      return finalResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<AyatData>> getSuratAyats(SuratData suratData) async {
    try {
      final String url =
          "http://api.alquran.cloud/v1/surah/${suratData.number}/editions/quran-simple,id.indonesian";
      final response = await http.get(Uri.parse(url));

      final ayatsData = jsonDecode(response.body)['data'] as List<dynamic>;

      final List<AyatData> finalResult = [];

      for (var i = 0; i < ayatsData[0]['ayahs'].length; i++) {
        final ayat = ayatsData[0]["ayahs"][i];
        final ayatData = AyatData.fromJSON(ayat);
        ayatData.translate = ayatsData[1]["ayahs"][i]["text"].toString();
        finalResult.add(ayatData);
      }
      return finalResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<AyatData> getAyatFromNumber(int number) async {
    try {
      final String url =
          "http://api.alquran.cloud/v1/ayah/$number/editions/quran-simple,id.indonesian";
      var result = await http.get(Uri.parse(url));
      var data = jsonDecode(result.body)['data'];

      var finalResult = AyatData.fromJSON(data[0]);
      finalResult.translate = data[1]['text'];

      return finalResult;
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }
}
