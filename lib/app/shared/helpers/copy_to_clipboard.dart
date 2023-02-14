import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Copy {
  static void copyCodeToClipboard(
      {required WidgetRef ref,
      required BuildContext context,
      required String text}) {
    ref.read(isCopiedProvider.notifier).state = true;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(AppStrings.copiedToClipboard)));
    Clipboard.setData(ClipboardData(text: text));

    Future.delayed(const Duration(seconds: 3), () {
      ref.read(isCopiedProvider.notifier).state = false;
    });
  }
}
