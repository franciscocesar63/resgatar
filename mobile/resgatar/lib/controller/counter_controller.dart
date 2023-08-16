import 'package:flutter/cupertino.dart';

class Counter extends ValueNotifier<int> {
  Counter() : super(0);

  increment() => value++;
  decrement() => value--;
}
