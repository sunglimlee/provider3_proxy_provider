import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider2_multi_provider/user.dart';

import 'counter_number.dart';


/*
* ProxyProvider0 and the others (the rest)
* Why use ProxyProvider - 외부에서 들어오는 데이터에 따라 값이 변경될 수 있기에 기존 프로바이더의 create 는 대응이 안된다.
* 당연히 MultiProvider 안에서 사용할 수 있지.
* MultiProvider 안에서 사용하면 복잡하니깐 변수로 돌려서 쉽게하는 방법도 있다.
*
* the others 들은 모두 MultiProvider 의 다른 Provider 들의 type 을 listening 하고 있다는 걸 명심하자. 갯수의 차이만 있다는 걸..
* 그렇지만 ProxyProvider0 는 listening 을 하지 않지만 인자로 값을 넣어주는 것도 실시간으로 변경시키는 방법으로 사용할 수 있다.
 */

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<User>(create: (context) => User(name: "Steve Lee", age: 52)),
        Provider<String>(create: (context) => "Stoney Creek",),
        Provider<String>(create: (context) => "Hamilton",), // 여기에 보다시피 String 의 타입으로 구분하기에 마지막에 있는게 출력된다.
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title; // 알지? widget.title 로 State<MyHomePage> 에서 사용하는걸..

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // 여기 같은 클래스안에 이 변수가 사용되고 있잖아... 뭐가 문젠데..
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    print(_counter);
  }

  @override
  Widget build(BuildContext context) {
    // [error] The instance member 'context' can't be accessed in an initializer.
    // [answer] 여기 State<MyHomePage 에는 context 가 존재하지 않는다. 그러니깐 없지. 방법은 context 가 있는 build 안에다가 넣어라.
    var name = Provider.of<User>(context).name.toString();
    final age = Provider.of<User>(context).age.toString();
    var address = Provider.of<String>(context).toString();
    // 값을 변경하는게 가능한가? 가능하지.. 그래서 전역변수처럼 사용할 수 있다. global variable
    Provider.of<User>(context).name = "Joseph Lee";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times: \n and Your name is  $name and age is $age '
                  'and address is $address',

            ),
            ProxyProvider0<int>(
              update: (_, __) => _counter, // 여기 보는 것 처럼 외부에 값이 바뀌는 걸 ProxyProvider0 가 계속 업데이트 해서 넘겨주고 있다.
                child: const CounterNumber(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

