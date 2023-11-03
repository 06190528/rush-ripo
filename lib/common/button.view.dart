import 'package:flutter/material.dart';
import 'package:rush_time_app/code/time.dart';

class MyButton extends StatelessWidget {
  final int index;
  final VoidCallback onPressed;
  final DateTime time; // timeのデータ型をStringとして指定

  MyButton({
    required this.index,
    required this.onPressed,
    required this.time, // colorを初期化
  });

  @override
  Widget build(BuildContext context) {
    // 時間と分を2桁の形式でフォーマット
    String formattedTime = DateTimeToString(time);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          height: 80.0,
          width: 150.0,
          child: Center(
            child: Text(
              formattedTime,
              style: TextStyle(
                color: Colors.white, // テキストの色を白に設定
              ),
            ), // timeを表示
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(185, 254, 165, 0),
        ),
      ),
    );
  }
}
