import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rush_time_app/common/ad_helper.dart';

class MyAdWidget extends StatelessWidget {
  final BannerAd myBanner = BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  MyAdWidget({required String adUnitId}) {
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // ここを追加
      children: [
        Container(
          child: AdWidget(ad: myBanner),
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
        ),
        // Text(
        //   "バナー広告だおんん？」",
        //   style: TextStyle(fontSize: 20, color: Colors.white),
        // )
      ],
    );
  }
}
