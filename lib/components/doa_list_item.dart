import 'package:flutter/material.dart';
import 'package:islamic_plus/components/horizontal_expanded.dart';
import 'package:islamic_plus/data/doa_data.dart';

class DoaListItem extends StatelessWidget {
  final DoaData doaData;
  const DoaListItem({Key? key, required this.doaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            HorizontaExpanded(
              child: Text(
                doaData.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            HorizontaExpanded(
              child: Text(
                doaData.arabic,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: "Arabic",
                ),
              ),
            ),
            const SizedBox(height: 10),
            HorizontaExpanded(
              child: Text(
                doaData.latin,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 10),
            HorizontaExpanded(
              child: Text(
                doaData.translation,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
