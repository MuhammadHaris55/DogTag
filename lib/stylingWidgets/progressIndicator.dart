import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Center progressIndicator(isLoading) {
  return Center(
    child: isLoading
        ? SpinKitFadingCube(
            color: themeColor,
            size: 50.0,
          )
        : Container(),
  );
}
