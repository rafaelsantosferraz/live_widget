library live_widget;

import 'package:flutter/material.dart';





/// An object wrapper that, when its object value changes, notify a set of observers.
class LiveData <T> {

  /// The set of callback functions to invoke on [value] change.
  Set<VoidCallback> observers = Set();


  T _value;

  T get value => _value;

  /// Sets [newValue] to [_value] and if [newValue] is different from [_value]
  /// invokes each [Observer] in [observers].
  set value(T newValue) {
    if(observers != null && _value != newValue) {
      observers.forEach((observer) => observer());
    }
    _value = newValue;
  }

  /// Creates a [LiveData] with a [initialValue].
  LiveData({@required T initValue}){
    _value = initValue;
  }

  /// Adds [observer] to [observers].
  void observe(VoidCallback observer) => observers.add(observer);

  /// Removes [observer] from [observers].
  void remove(VoidCallback observer) => observers.remove(value);

  /// Removes all observers from [observers].
  void dispose() => observers = null;
}





class LiveWidget<T> extends StatefulWidget {

  const LiveWidget({
    @required this.liveData,
    @required this.builder,
    this.child
  }): assert(liveData != null),
      assert(builder  != null);

  final LiveData<T> liveData;
  final Widget Function(BuildContext, T, Widget) builder;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _LiveWidgetState<T>();
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
      widget.builder(context, widget.liveData.value, widget.child);

  void _onValueChange() =>
      setState(() {});
}
