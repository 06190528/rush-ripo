import 'package:flutter/material.dart';
import 'package:rush_time_app/code/select.code.dart';
import 'package:rush_time_app/common/ad_helper.dart';
import 'package:rush_time_app/common/banner.view.dart';
import 'package:rush_time_app/common/button.view.dart';
import 'package:rush_time_app/common/provider.dart';
import 'package:rush_time_app/view/count-down.view.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TimeProvider timeProvider = TimeProvider(DateTime.now());
  List<int> items = List.generate(20, (index) => index);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          addMoreItems(items);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          MyAdWidget(
            adUnitId: AdHelper.bannerAdUnitId, // バナー広告用の広告ユニットIDを指定
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: (items.length / 2).ceil(),
              itemBuilder: (context, index) {
                int first = index * 2;
                int second = first + 1;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      index: first,
                      time: timeProvider.getAddedTime(first),
                      onPressed: () {
                        final setTime =
                            Provider.of<SetTime>(context, listen: false);
                        setTime.setTime(timeProvider.getAddedTime(first));
                        //print(setTime.getTime());
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountDownPage(),
                          ),
                        );
                      },
                    ),
                    if (second < items.length)
                      MyButton(
                        index: second,
                        time: timeProvider.getAddedTime(second),
                        onPressed: () {
                          final setTime =
                              Provider.of<SetTime>(context, listen: false);
                          setTime.setTime(timeProvider.getAddedTime(second));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountDownPage(),
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
          // Container(
          //   height: 100.0,
          //   width: double.infinity,
          //   color: Colors.red,
          //   child: Center(
          //     child: Text('Ad-like Banner'),
          //   ),
          // ),
          MyAdWidget(
            // AdMobのバナー広告を表示
            adUnitId: AdHelper.bannerAdUnitId,
          ),
        ],
      ),
    );
  }

  // Assuming dispose logic exists to clean up resources
  // The dispose function could be implemented here or imported from another file
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
