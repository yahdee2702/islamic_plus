import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:islamic_plus/api/doa_api.dart';
import 'package:islamic_plus/components/doa_list_item.dart';
import 'package:islamic_plus/components/load_alert_dialog.dart';
import 'package:islamic_plus/components/loading_dialog.dart';
import 'package:islamic_plus/components/search_widget.dart';
import 'package:islamic_plus/data/doa_data.dart';
import 'package:islamic_plus/utils/event_listener.dart';
import 'package:islamic_plus/utils/search_controller.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({Key? key}) : super(key: key);

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  List<DoaData> doaList = [];
  Function? listSetState;
  final EventListener onDoaChanged = EventListener();
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = SearchController<DoaData>(
      defaultList: doaList,
      filtering: (v, s) {
        try {
          return RegExp("(?:$s)", caseSensitive: false).hasMatch(v.title);
        } catch (e) {
          return false;
        }
      },
    );

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      fetchDoa(context);
    });

    onDoaChanged.listen(
      (mListener, args) => {
        _searchController.updateList(doaList),
        listSetState?.call(() {}),
      },
    );
  }

  Future<void> fetchDoa(BuildContext mContext) async {
    // Show Loading Dialog
    showDialog(
      barrierDismissible: false,
      context: mContext,
      builder: (_) => const LoadingDialog(),
    );

    try {
      doaList = await DoaAPI.getAllDoa();
      Navigator.pop(mContext);
      onDoaChanged.fire();
    } catch (e) {
      Navigator.pop(mContext);
      showDialog(
        context: context,
        builder: (_) => LoadAlertDialog(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            doaList = await DoaAPI.getAllDoa();
            onDoaChanged.fire();
          } catch (e) {
            showDialog(
              context: context,
              builder: (_) => LoadAlertDialog(context),
            );
          }
        },
        child: StatefulBuilder(
          builder: (context, mSetState) {
            listSetState = mSetState;
            final finalList = _searchController.getResult();
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  // leading: null,
                  floating: true,
                  pinned: true,
                  snap: false,
                  title: const Text(
                    "Do'a",
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
                        child: DoaListItem(doaData: finalList[index]),
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
