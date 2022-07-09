import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterNumber extends StatelessWidget {
  const CounterNumber({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<int>(context).toString(); // ProxyProvider0 가 자동으로 갱신해준다.
    return
      Text(
        counter,
        style: Theme.of(context).textTheme.headline4,
      );
  }
}
