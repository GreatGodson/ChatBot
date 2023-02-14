import 'package:chat_gpt/app/shared/helpers/copy_to_clipboard.dart';
import 'package:chat_gpt/app/shared/helpers/dimensions.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatMessage extends ConsumerWidget {
  ChatMessage({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;
  RegExp regExp = RegExp(r'[@#$%^&*()"{}|<>]');

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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              : regExp.hasMatch(text)
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
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
                                          ref: ref,
                                          context: context,
                                          text: text);
                                    },
                                    tooltip: AppStrings.copyToClipboard,
                                    icon: Icon(
                                      ref.watch(isCopiedProvider)
                                          ? Icons.check
                                          : Icons.copy,
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
                                        style: TextStyle(
                                            color: AppColors.randomColor()),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Text(
                        text.trim(),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
        ],
      ),
    );
  }
}
