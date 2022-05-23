import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islamic_plus/data/doa_data.dart';

class DoaAPI {
  static Future<dynamic> getAllDoa() async {
    const String url = "https://islamic-api-zhirrr.vercel.app/api/doaharian";
    final response = await http.get(Uri.parse(url));
    final dataArray = jsonDecode(response.body)["data"] as List<dynamic>;

    final List<DoaData> doaArray = [];

    for (var data in dataArray) {
      var doa = DoaData.fromJSON(data);
      doaArray.add(doa);
    }

    return doaArray;
  }
}
