import 'package:chat_gpt/app/shared/helpers/copy_to_clipboard.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/views/widgets/response_type_widget/code_widget.dart';
import 'package:chat_gpt/app/shared/views/widgets/response_type_widget/link_widget.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/theme/app_colors.dart';

class ResponseTypeHelper {
  static RegExp codeRegEx = RegExp(r'[@#$%^&*(){}|<>]');
  static RegExp linkRegex = RegExp(
      r"(http|https):\/\/([a-zA-Z0-9]+\.)+[a-zA-Z]{2,}([\/\w \.-]*)*\/?");

  static Widget getLinkRichText(String text, BuildContext context) {
    List<TextSpan> textSpans = [];

    int index = 0;
    linkRegex.allMatches(text).forEach((match) {
      // Add the preceding text
      if (index < match.start) {
        textSpans.add(TextSpan(
          text: text.substring(index, match.start),
          style: Theme.of(context).textTheme.titleMedium,
        ));
      }

      // Add the link text
      textSpans.add(TextSpan(
        text: match.group(0),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColors.blueColor),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            String? url = match.group(0);
            if (url != null) {
              launchUrl(Uri.parse(url));
            }

            // Handle the tap on the link
          },
      ));

      // Update the index
      index = match.end;
    });

    // Add the remaining text
    if (index < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(index),
        style: Theme.of(context).textTheme.titleMedium,
      ));
    }

    return linkWidget(textSpans);
  }

  static Widget getCodeRichText(
      String text, BuildContext context, WidgetRef ref) {
    List<TextSpan> textSpans = [];

    int index = 0;
    codeRegEx.allMatches(text).forEach((match) {
      // Add the preceding text
      if (index < match.start) {
        textSpans.add(TextSpan(
          text: text.substring(index, match.start),
          style: Theme.of(context).textTheme.titleMedium,
        ));
      }

      // Add the link text
      textSpans.add(TextSpan(
        text: match.group(0),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColors.blueColor),
      ));

      // Update the index
      index = match.end;
    });

    // Add the remaining text
    if (index < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(index),
        style: Theme.of(context).textTheme.titleMedium,
      ));
    }

    return codeWidget(ref: ref, context: context, text: text);
  }
}
