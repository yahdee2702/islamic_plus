import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:islamic_plus/api/quran_api.dart';
import 'package:islamic_plus/components/load_alert_dialog.dart';
import 'package:islamic_plus/components/loading_dialog.dart';
import 'package:islamic_plus/components/search_widget.dart';
import 'package:islamic_plus/components/surat_list_item.dart';
import 'package:islamic_plus/data/surat_data.dart';
import 'package:islamic_plus/utils/event_listener.dart';
import 'package:islamic_plus/utils/search_controller.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<SuratData> _quranSurats = [];
  Function? _listSetState;

  final EventListener onSuratsChanged = EventListener();
  late final SearchController _searchController;

  // var _searchField = "";
  // var _searchedSurahs = <SuratData>[];
  // var _activeSearch = false;
  // final _searchNode = FocusNode();
  // final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController = SearchController<SuratData>(
      defaultList: _quranSurats,
      filtering: (v, s) {
        try {
          return RegExp("(?:$s)", caseSensitive: false).hasMatch(v.nameLatin);
        } catch (e) {
          return false;
        }
      },
    );

    onSuratsChanged.listen(
      (listener, args) => {
        _searchController.updateList(_quranSurats),
        _listSetState?.call(() {}),
      },
    );

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      fetchQuran(context);
    });
  }

  Future<void> fetchQuran(BuildContext mContext) async {
    // Show Loading Dialog
    showDialog(
      barrierDismissible: false,
      context: mContext,
      builder: (_) => const LoadingDialog(),
    );

    try {
      _quranSurats = await QuranAPI.getAllSurah();
      Navigator.pop(mContext);
      onSuratsChanged.fire();
    } catch (e) {
      Navigator.pop(mContext);
      showDialog(
        context: context,
        builder: (_) => LoadAlertDialog(
          context,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            _quranSurats = await QuranAPI.getAllSurah();
            onSuratsChanged.fire();
          } catch (e) {
            showDialog(
              context: context,
              builder: (_) => LoadAlertDialog(context),
            );
          }
        },
        child: StatefulBuilder(
          builder: (context, mSetState) {
            _listSetState = mSetState;
            final finalList = _searchController.getResult();
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  // leading: null,
                  floating: true,
                  pinned: true,
                  snap: false,
                  title: const Text(
                    "Al-Qur'an",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity, 80),
                    child: SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: SearchWidget(
                        controller: _searchController,
                        onCleared: () {
                          mSetState(() {});
                        },
                        onSearched: () {
                          mSetState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SuratListItem(suratData: finalList[index]),
                      );
                    },
                    childCount: finalList.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
