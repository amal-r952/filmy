import 'package:filmy/src/widgets/cancel_alert_box.dart';
import 'package:filmy/src/widgets/otp_message.dart';
import 'package:flutter/material.dart';

///it contain common functions
class Utils {}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

Future<dynamic> push(BuildContext context, Widget route) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => route));
}

void pop(BuildContext context) {
  return Navigator.pop(context);
}

Future<dynamic> pushAndRemoveUntil(
    BuildContext context, Widget route, bool goBack) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => route), (route) => goBack);
}

Future<dynamic> pushAndReplacement(BuildContext context, Widget route) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => route));
}

void cancelAlertBox(
    {context,
    msg,
    text1,
    text2,
    route,
    double? insetPadding,
    double? contentPadding,
    double? titlePadding}) {
  showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return CancelAlertBox(
          title: msg,
          text1: text1,
          text2: text2,
          route: route,
          contentPadding: contentPadding!,
          titlePadding: titlePadding!,
          insetPadding: insetPadding!,
        );
      });
}

void showAlert(context, String msg) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(msg),
//        content: new Text("Alert Dialog body"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void otpAlertBox({context, title, route, stayOnPage}) {
  showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return OtpMessage(
          title: title,
          route: route,
          stayOnPage: stayOnPage,
        );
      });
}
