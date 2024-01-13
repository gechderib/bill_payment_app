import 'package:billpayment/constants/styles/decoration.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.horizontalMargin,
    required this.verticalMargin,
    required this.btnName,
    required this.onPress,
    // required this.decoration
  }) : super(key: key);
  final Widget btnName;
  final Function onPress;
  final double horizontalMargin;
  final double verticalMargin;
  // final BoxDecoration decoration;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPress();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        height: 55,
        decoration: buttonDecoration,
        child: Center(child: btnName),
      ),
    );
  }
}
