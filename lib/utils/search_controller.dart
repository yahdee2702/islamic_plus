import 'package:islamic_plus/components/search_widget.dart';
import 'package:islamic_plus/utils/event_listener.dart';

class SearchController<T> {
  late List<T> _defaultList;
  late final bool Function(T currentElement, String result) _filtering;

  EventListener onSearchedListener = EventListener();
  EventListener onClearedListener = EventListener();
  List<T> _searchResultList = [];
  SearchWidget? _searchWidget;
  bool _isSearching = false;

  SearchController({
    required List<T> defaultList,
    required bool Function(T currentElement, String result) filtering,
  }) {
    _defaultList = defaultList;
    _filtering = filtering;
  }

  void setSearchWidget(SearchWidget widget) {
    _searchWidget = widget;
  }

  void updateList(List<T> newList) {
    _defaultList = newList;
  }

  void reset() {
    if (_searchWidget == null) return;
    _searchWidget?.onReset.fire();
    _isSearching = false;
    _searchResultList.clear();
    onClearedListener.fire();
  }

  void onSearch(String result) {
    if (result.isEmpty) {
      _isSearching = false;
      onClearedListener.fire();
      return;
    }
    _isSearching = true;
    _searchResultList = _defaultList.where((element) {
      var a = _filtering(element, result);
      return a;
    }).toList();
    onSearchedListener.fire();
  }

  List<T> getSearchedList() => _searchResultList;
  List<T> getResult() => _isSearching ? _searchResultList : _defaultList;
}
