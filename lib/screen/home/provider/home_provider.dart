import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeProvider extends ChangeNotifier
{
  double webProgress=0;
  InAppWebViewController? inAppWebViewController;

  void progressChange(double progress)
  {
    webProgress=progress;
    notifyListeners();
  }
}