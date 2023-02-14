import 'package:chat_gpt/app/shared/helpers/copy_to_clipboard.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget codeWidget(
    {required WidgetRef ref, required BuildContext context, required text}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Copy.copyCodeToClipboard(
                        ref: ref, context: context, text: text);
                  },
                  tooltip: AppStrings.copyToClipboard,
                  icon: Icon(
                    ref.watch(isCopiedProvider) ? Icons.check : Icons.copy,
                    size: 20,
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  for (var word in text.split(" "))
                    TextSpan(
                      text: "$word ",
                      style: TextStyle(color: AppColors.randomColor()),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
