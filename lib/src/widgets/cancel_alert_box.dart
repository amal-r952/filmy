import 'package:filmy/src/utils/utils.dart';
import 'package:flutter/material.dart';

class CancelAlertBox extends StatefulWidget {
  String? title;
  String? text1;
  String? text2;
  Widget? route;
  double? insetPadding;
  double? titlePadding;
  double? contentPadding;
  CancelAlertBox(
      {this.title,
      this.text1,
      this.text2,
      this.route,
      this.contentPadding,
      this.insetPadding,
      this.titlePadding});
  @override
  _CancelAlertBoxState createState() => _CancelAlertBoxState();
}

class _CancelAlertBoxState extends State<CancelAlertBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(context, widget.route!);
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          vertical: screenHeight(context, dividedBy: widget.insetPadding!),
        ),
        titlePadding: EdgeInsets.symmetric(
          horizontal: screenWidth(context, dividedBy: widget.titlePadding!),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal:
                screenWidth(context, dividedBy: widget.contentPadding!)),
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.transparent,
        // title: Container(
        //       height: screenHeight(context,dividedBy: 20),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.vertical(top: Radius.circular(10))
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //
        //         SizedBox(
        //           height: screenHeight(context,dividedBy: 100),
        //         ),
        //
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //
        //           children: [
        //
        //
        //            SizedBox(
        //              width: screenWidth(context,dividedBy: 4),
        //            ),
        //
        //             Text(widget.title),
        //           ],
        //         ),
        //       ],
        //     )),
        content: Container(
          // height: screenHeight(context,dividedBy: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screenHeight(context, dividedBy: 150),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title ?? " ",
                    style: const TextStyle(
                        fontFamily: "sfProSemiBold",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 150),
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth(context, dividedBy: 20),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: screenWidth(context, dividedBy: 1.2),
                    child: Text(
                      // "If you have already made the deposit, you will receive it within 3 working days.  ",
                      widget.text1 ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFProText-Regular',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context, dividedBy: 20),
                  ),
                ],
              ),
              Text(
                // "To make another booking,head to, ",
                widget.text2 ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFProText-Regular',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: screenHeight(context, dividedBy: 100),
              ),
              const Text(
                "Tap anywhere to close this pop up.",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'SFProText-Regular',
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
