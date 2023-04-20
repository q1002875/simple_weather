
import 'package:flutter/material.dart';
import 'CustomText.dart';

 showCustomDialog(
    BuildContext context, String title, String content,Color titlecolor,Color contentColor) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CustomDialogBox(title: title,content: content,titleColor: titlecolor,contentColor: contentColor,);
    },
  );
}


class CustomDialogBox extends StatefulWidget {
  final String title;
  final String content;
  final Color titleColor;
  final Color contentColor;
  CustomDialogBox({ this.title,  this.content,this.titleColor,this.contentColor});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: screenWidth/1.5,
        color: Color.fromARGB(255, 255, 255, 255),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              textContent: widget.title,
              textColor:widget.titleColor,
              fontSize: 20,
              align: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomText(
              textContent: widget.content,
              textColor: widget.contentColor,
              fontSize: 14,
              align: TextAlign.left,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        ),
      ),
    );
  }
}
