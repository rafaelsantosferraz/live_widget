library live_widget;

import 'package:flutter/material.dart';





/// An object wrapper that, when its object value changes, notify a set of observers.
///
/// [T] defines the type of the wrapped object.
class LiveData <T> {

  /// The set of callback functions to invoke on [value] change.
  Set<void Function(T)> observers = Set();

  /// The value this wraps.
  T _data;

  /// Access [_data] value.
  T get value => _data;

  /// Sets [newValue] to [_data] and if [newValue] is different from [_data]
  /// invokes each [Observer] in [observers].
  set value(newValue) {
    if(observers != null && _data != newValue) {
      observers.forEach((observer) => observer(newValue));
    }
    _data = newValue;
  }

  /// Creates a [LiveData] with a [initialValue].
  LiveData({@required T initValue}){
    _data = initValue;
  }

  /// Adds [observer] to [observers].
  void observe(void Function(T) observer) => observers.add(observer);

  /// Removes [observer] from [observers].
  void remove(void Function(T) observer) => observers.remove(value);

  /// Removes all observers from [observers].
  void dispose() => observers.clear();
}





class LiveWidget<T> extends StatefulWidget {

  final LiveData<T> liveData;
  final Widget Function(T) onValueChange;

  LiveWidget({this.liveData, this.onValueChange});

  @override
  _LiveWidgetState<T> createState() => _LiveWidgetState<T>();
}

class _LiveWidgetState<T> extends State<LiveWidget<T>> {



  @override
  void initState() {
    widget.liveData.observe(_onValueChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.liveData.remove(_onValueChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.onValueChange != null ? widget.onValueChange(widget.liveData.value) : null;

  void _onValueChange(T value) =>
      setState(() {});
}
