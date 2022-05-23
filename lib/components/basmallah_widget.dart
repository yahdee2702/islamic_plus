import 'package:flutter/material.dart';
import 'package:islamic_plus/components/horizontal_expanded.dart';

class BasmallahWidget extends StatelessWidget {
  const BasmallahWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: HorizontaExpanded(
          child: Text(
            "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: "Arabic",
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}
