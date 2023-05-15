
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iron_mind/adhelper/ad_helper.dart';
import 'package:iron_mind/const/boxname.dart';
import 'package:iron_mind/layout/setting_lay_out.dart';
import 'package:iron_mind/model/status_model.dart';

class ListSetting extends StatefulWidget {

  const ListSetting({Key? key}) : super(key: key);

  @override
  State<ListSetting> createState() => _ListSettingState();
}

class _ListSettingState extends State<ListSetting> {
  final box = Hive.box<StatusModel>(userBox);
  BannerAd? _bannerAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

  }

  @override
  Widget build(BuildContext context) {
    final status = box.values.last;

    return SettingLayOut(
      topText: 'your own Enemy',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                    color: Colors.black12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...List.generate(status.comList.length, (index) {
                          if (index == 0) {
                            return Text(
                              '${index+1}. ${status.comList[index]}',
                              style: const TextStyle(
                                fontFamily: 'oswald',
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }

                          return Text(
                            '\n${index+1}. ${status.comList[index]}',
                            style: const TextStyle(
                              fontFamily: 'oswald',
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TODO: Display a banner when ready
          if (_bannerAd != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
      ),
      buttonText: 'Back',
      onPressedBottomButton: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }
}
