import 'package:flutter/material.dart';
import 'package:islamic_plus/components/ayat_list_item.dart';
import 'package:islamic_plus/components/basmallah_widget.dart';
import 'package:islamic_plus/data/ayat_data.dart';
import 'package:islamic_plus/data/surat_data.dart';

class SuratScreen extends StatelessWidget {
  final SuratData suratData;
  final List<AyatData> ayatData;
  final bool requiresBasmallah;

  const SuratScreen({
    Key? key,
    required this.suratData,
    required this.ayatData,
    required this.requiresBasmallah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: null,
            floating: true,
            pinned: false,
            snap: false,
            centerTitle: true,
            title: Hero(
              tag: suratData.nameLatin,
              child: Text(
                suratData.nameLatin,
                softWrap: false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0 && requiresBasmallah) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const BasmallahWidget(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: AyatListItem(ayat: ayatData[index]),
                        ),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      AyatListItem(ayat: ayatData[index]),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
              childCount: ayatData.length,
            ),
          )
        ],
      ),
    );
  }
}
