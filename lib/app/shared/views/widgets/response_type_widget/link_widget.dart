import 'package:flutter/cupertino.dart';

Widget linkWidget(List<TextSpan> textSpans){
  return Expanded(
    child: RichText(
      text: TextSpan(
        children: textSpans,
      ),
    ),
  );
}