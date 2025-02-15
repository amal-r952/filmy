import 'package:filmy/src/utils/utils.dart';
import 'package:flutter/material.dart';

class OtpMessage extends StatefulWidget {
  String? title;
  String? text1;
  Widget? route;
  bool? stayOnPage;
  OtpMessage({this.title, this.route, this.stayOnPage});
  @override
  _OtpMessageState createState() => _OtpMessageState();
}

class _OtpMessageState extends State<OtpMessage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.stayOnPage == false) push(context, widget.route!);
        if (widget.stayOnPage == true) pop(context);
      },
      child: AlertDialog(
        insetPadding:
            EdgeInsets.symmetric(vertical: screenWidth(context, dividedBy: 7)),
        contentPadding: EdgeInsets.only(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Container(
          height: screenHeight(context, dividedBy: 6),
          width: screenWidth(context, dividedBy: 1.22),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context, dividedBy: 40),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title ?? " ",
                    style: TextStyle(
                        fontFamily: "sfProSemiBold",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 20),
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 100),
              ),
              Text(
                "Tap anywhere to close this pop up.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Muli',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
