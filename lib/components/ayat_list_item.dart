import 'package:flutter/material.dart';
import 'package:islamic_plus/components/horizontal_expanded.dart';
import 'package:islamic_plus/data/ayat_data.dart';
import 'package:islamic_plus/themes/islamic_theme.dart';
import 'package:islamic_plus/utils/surat_utils.dart';

class AyatListItem extends StatelessWidget {
  final AyatData ayat;
  const AyatListItem({
    Key? key,
    required this.ayat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            HorizontaExpanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text.rich(
                  TextSpan(
                    text: ayat.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: "Arabic",
                    ),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: IslamicTheme.anotherBlack,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    SuratUtils.convertToArabicNumber(
                                      ayat.numberInSurah.toString(),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    ayat.translate ?? "No translation :(",
                    style: const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
