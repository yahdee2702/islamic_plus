import 'package:flutter/material.dart';
import 'package:islamic_plus/utils/event_listener.dart';
import 'package:islamic_plus/utils/search_controller.dart';

class SearchWidget extends StatefulWidget {
  final SearchController controller;
  final String hintText;
  final Function onSearched;
  final Function onCleared;
  final EventListener onReset = EventListener();

  SearchWidget({
    Key? key,
    required this.controller,
    this.hintText = "Search...",
    required this.onSearched,
    required this.onCleared,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchNode = FocusNode();
  final _searchTextController = TextEditingController();
  bool _exitVisibility = false;

  @override
  void initState() {
    super.initState();
    widget.controller.setSearchWidget(widget);

    widget.onReset.listen((listener, args) {
      setState(() {
        _searchTextController.clear();
        _searchNode.unfocus();
        _exitVisibility = _searchTextController.text.isNotEmpty;
      });
    });

    widget.controller.onSearchedListener.clear();
    widget.controller.onClearedListener.clear();

    widget.controller.onSearchedListener.listen(
      (listener, args) => widget.onSearched(),
    );
    widget.controller.onClearedListener.listen(
      (listener, args) => widget.onCleared(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      child: TextField(
        focusNode: _searchNode,
        controller: _searchTextController,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black.withOpacity(0.75),
          ),
          suffixIcon: Visibility(
            visible: _exitVisibility,
            child: IconButton(
              onPressed: () {
                widget.controller.reset();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 14,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.25,
            ),
          ),
        ),
        onChanged: (res) {
          if (_exitVisibility == false && res.isNotEmpty ||
              _exitVisibility == true && res.isEmpty) {
            setState(() {});
          }
          _exitVisibility = res.isNotEmpty;

          widget.controller.onSearch(res);
        },
      ),
    );
  }
}
