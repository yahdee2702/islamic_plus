import 'package:flutter/material.dart';
import 'package:islamic_plus/api/quran_api.dart';
import 'package:islamic_plus/components/load_alert_dialog.dart';
import 'package:islamic_plus/components/loading_dialog.dart';
import 'package:islamic_plus/data/surat_data.dart';
import 'package:intl/intl.dart' as intl;
import 'package:islamic_plus/screens/surat_screen.dart';
import 'package:islamic_plus/themes/islamic_theme.dart';
import 'package:islamic_plus/utils/surat_utils.dart';

class SuratListItem extends StatelessWidget {
  final SuratData suratData;
  const SuratListItem({
    Key? key,
    required this.suratData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.black,
      onTap: () async {
        BuildContext? dialogContext;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dContext) {
            dialogContext = dContext;

            return const LoadingDialog();
          },
        );

        try {
          var requiresBasmallah = true;
          var suratAyats = await QuranAPI.getSuratAyats(suratData);

          if (dialogContext == null) return;
          Navigator.of(dialogContext!).pop();

          switch (suratData.number) {
            case 1:
            case 9:
              requiresBasmallah = false;
              break;
            default:
              suratAyats[0] = SuratUtils.removeBasmallah(suratAyats[0]);
              break;
          }

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SuratScreen(
                suratData: suratData,
                ayatData: suratAyats,
                requiresBasmallah: requiresBasmallah,
              ),
              transitionsBuilder: (c, anim, a2, child) {
                return SlideTransition(
                  position: anim.drive(
                    Tween(
                      end: Offset.zero,
                      begin: const Offset(1.0, 0.0),
                    ).chain(
                      CurveTween(curve: Curves.easeInOut),
                    ),
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
              fullscreenDialog: true,
            ),
          );
        } catch (e) {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (_) => LoadAlertDialog(
              context,
              description: "There was an error while trying to load the ayahs.",
            ),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: IslamicTheme.anotherBlack,
                  borderRadius: BorderRadius.all(IslamicTheme.defaultRadius),
                ),
                child: Text(
                  intl.NumberFormat("00").format(suratData.number),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: suratData.nameLatin,
                    child: Text(
                      suratData.nameLatin,
                      softWrap: false,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    "${suratData.revelationType} | ${suratData.ayahsQuantity} Ayahs",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.75),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  suratData.name,
                  textDirection: TextDirection.rtl,
                  softWrap: false,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
