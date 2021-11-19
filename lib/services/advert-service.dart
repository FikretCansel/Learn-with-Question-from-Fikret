import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;
  final String _bannerAd = "ca-app-pub-1672635625772574/5968598000";
  final String _interstitialAd="ca-app-pub-1672635625772574/9857486520";



  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd bannerAd = BannerAd(
      adUnitId: _bannerAd,
      size: AdSize.smartBanner,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    bannerAd
      ..load()
      ..show(
        anchorOffset: 50,
      );

    bannerAd.dispose();
  }

  showInterstitial() {
    InterstitialAd interstitialAd = InterstitialAd(
      adUnitId: _interstitialAd,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}