import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Browserprovider extends ChangeNotifier
{
  InAppWebViewController? inAppWebViewController;

  double changedProgress = 0;

  void onProgressChangged(double progress)
  {
    changedProgress = progress;
    notifyListeners();
  }


}