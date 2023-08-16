import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GOTOトラベル計算機'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _price = 0;
  int _person = 1;
  int _stay = 0;
  String text = '';

  int _minus = 0;
  int _coupon = 0;
  int _pay = 0;

  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    // 宿泊日数のリストを作成
    List<DropdownMenuItem> stayList = List.generate(
      7,
      (index) => DropdownMenuItem(
        value: index + 1,
        child: Text('${index + 1}泊${index + 2}日'),
      ),
    );

    // 宿泊人数のリストを作成
    List<DropdownMenuItem> peopleList = List.generate(
      10,
      (index) => DropdownMenuItem(
        value: index + 1,
        child: Text('${index + 1}人'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      "宿泊日数",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: DropdownButton(
                    value: _stay,
                    items: [
                      const DropdownMenuItem(
                        value: 0,
                        child: Text('日帰り'),
                      ),
                      ...stayList, //　リストを結合
                      const DropdownMenuItem(
                        value: 10,
                        child: Text('8泊以上'),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _stay = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      "宿泊人数",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: DropdownButton(
                    value: _person,
                    items: peopleList, //　リストを使用
                    onChanged: (value) {
                      setState(() {
                        _person = value;
                      });
                    },
                  ),
                )
              ],
            ),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Colors.red,
              rightButtonFn: () {
                setState(() {
                  text = text.substring(0, text.length - 1);
                });
              },
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.red,
              ),
              leftButtonFn: () {
                print('left button clicked');
              },
              leftIcon: Icon(
                Icons.check,
                color: Colors.red,
              ),
            ),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      "料金",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(formatter.format(_price)),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      "割引",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(formatter.format(_minus)),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      "支払額",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    formatter.format(_pay),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      "クーポン",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(formatter.format(_coupon)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
      _price = int.parse(text);

      _minus = (_price * 0.35).toInt();
      _coupon = (_price * 0.15).toInt();
      _pay = _price - _minus;
    });
  }
}
