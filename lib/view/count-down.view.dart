import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rush_time_app/code/time.dart';
import 'package:rush_time_app/common/provider.dart';
import 'package:rush_time_app/main.dart';
import 'package:provider/provider.dart';

class CountDownPage extends StatefulWidget {
  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  late DateTime targetTime;
  Duration remainingTime = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    final setTime = Provider.of<SetTime>(context, listen: false);
    targetTime = setTime.getTime();
    remainingTime = targetTime.difference(DateTime.now());
    bool finished = false;
    // 1秒ごとに残り時間を更新するタイマーを開始します
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = targetTime.difference(DateTime.now());
        if (remainingTime.isNegative || remainingTime == Duration.zero) {
          timer.cancel(); // タイマーをキャンセルする
          finished = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Main(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final setTime = Provider.of<SetTime>(context);
    DateTime setedTime = setTime.getTime();
    //print('カウントダウン${formattedTime}');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("バナー広告"),
        // backgroundColor: Colors.blue,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            Center(
              child: Text(
                  remainingTime.inSeconds < 0
                      ? 'Error'
                      : DurationToString(remainingTime),
                  style: TextStyle(fontSize: 60.0, color: Colors.white)),
            ),
            Text(
              remainingTime.inSeconds < 0
                  ? 'Error'
                  : 'アラーム時刻：${DateTimeToString(setedTime)}',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            TextButton(
              child: Text("cancel", style: TextStyle(fontSize: 20.0)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Main(),
                  ),
                );
              },
            ),
          ]),
          Spacer(), // TextButtonとContainerの間に余白が追加
          Container(
            height: 100.0,
            width: double.infinity,
            color: Colors.red,
            child: Center(
              child: Text('Ad-like Banner'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // タイマーをキャンセル
    super.dispose();
  }
}
