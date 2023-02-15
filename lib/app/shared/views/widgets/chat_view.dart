import 'package:chat_gpt/app/shared/helpers/dimensions.dart';
import 'package:chat_gpt/app/shared/helpers/response_type_helper.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

/// this screen contains the listview for the chat screen

class ChatMessage extends ConsumerWidget {
  const ChatMessage({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: sender == AppStrings.user
          ? AppColors.primaryColor
          : AppColors.botChatColor,
      child: Row(
        children: [
          sender == AppStrings.user
              ? Container(
                  height: 50,
                  width: 50,
                  color: AppColors.senderChatColor,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.whiteColor,
                    size: 32,
                  ),
                )
              : Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        image: AssetImage(AssetStrings.gptIcon),
                        fit: BoxFit.cover),
                  ),
                ),
          const XBox(10),
          sender == AppStrings.user
              ? Expanded(
                  child: Text(
                    text.trim(),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : ResponseTypeHelper.codeRegEx.hasMatch(text)
                  ? ResponseTypeHelper.getCodeRichText(text, context, ref)
                  : ResponseTypeHelper.linkRegex.hasMatch(text)
                      ? ResponseTypeHelper.getLinkRichText(text.trim(), context)
                      : Expanded(
                          child: SelectableText(
                            text.trim(),
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
        ],
      ),
    );
  }
}
