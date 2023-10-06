import 'package:flutter/material.dart';

class CustomDialogPopUp extends StatelessWidget {
  final bool hasAction;
  final String titleModal;
  final Widget content;
  final String? leftButtonText;
  final String? rightButtonText;

  const CustomDialogPopUp(
      {super.key,
      required this.titleModal,
      required this.content,
      this.leftButtonText,
      this.hasAction = true,
      this.rightButtonText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CustomText(text: titleModal)],
      ),
      content: content,
      actions: hasAction
          ? <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(leftButtonText ?? 'Batal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(rightButtonText ?? 'Submit'),
                    ),
                  ],
                ),
              ),
            ]
          : null,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;

  const CustomText(
      {super.key,
      required this.text,
      this.textAlign,
      this.size,
      this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
