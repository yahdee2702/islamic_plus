class Listener {
  late EventListener _mEventListener;
  final Function function;

  Listener(EventListener eventListener, {required this.function}) {
    _mEventListener = eventListener;
  }

  void stop() {
    _mEventListener._listeners.remove(this);
  }
}

class EventListener {
  final List<Listener> _listeners = [];

  EventListener([
    Function(
      Listener listener,
      List<dynamic>? args,
    )?
        listenFunction,
  ]) {
    if (listenFunction != null) {
      listen(listenFunction);
    }
  }

  Listener listen(
    Function(
      Listener listener,
      List<dynamic>? args,
    )
        listenFunction,
  ) {
    var newListener = Listener(this, function: listenFunction);
    _listeners.add(newListener);

    return newListener;
  }

  void fire([List<dynamic>? args]) {
    if (_listeners.isEmpty) return;
    var tempList = _listeners.toList();

    for (var listener in tempList) {
      listener.function.call(listener, args);
    }
  }

  void clear() {
    _listeners.clear();
  }
}
