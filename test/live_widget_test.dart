import 'package:flutter_test/flutter_test.dart';

import 'package:live_widget/live_widget.dart';

void main() {
  test('adds one to livedata counter', () {

    //arrange
    final _counter = LiveData(initValue: 0);
    bool _wasNotified = false;
    _counter.observe(() => _wasNotified = true);

    //act
    _counter.value++;

    //assert
    expect(_counter.value, 1);
    expect(_wasNotified  , true);
  });
}
