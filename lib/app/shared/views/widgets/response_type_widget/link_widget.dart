import 'package:flutter/material.dart';

Widget linkWidget(List<TextSpan> textSpans) {
  return Expanded(
    child: SelectableText.rich(
      TextSpan(
        children: textSpans,
      ),
    ),
  );
}
