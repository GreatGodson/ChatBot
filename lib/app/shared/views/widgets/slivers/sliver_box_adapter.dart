import 'dart:async';
import 'dart:math';

import 'package:chat_gpt/app/modules/home/views/home_screen.dart';
import 'package:chat_gpt/app/shared/helpers/dimensions.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isCopiedProvider = StateProvider((ref) => false);

class CustomSliverToBoxAdapter extends ConsumerStatefulWidget {
  CustomSliverToBoxAdapter({Key? key, required this.messages})
      : super(key: key);

  final List<ChatMessage> messages;

  @override
  ConsumerState<CustomSliverToBoxAdapter> createState() =>
      _CustomSliverToBoxAdapterState();
}

class _CustomSliverToBoxAdapterState
    extends ConsumerState<CustomSliverToBoxAdapter> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      /// height: 500,
      height: context.deviceHeight(0.64),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 40),
                reverse: true,
                itemCount: widget.messages.length,
                itemBuilder: (context, index) {
                  return widget.messages[index];
                }),
          ),
          ref.watch(isTyping.notifier).state
              ? const ThreeDots()
              : const SizedBox.shrink(),
        ],
      ),
    ));
  }
}

class ChatMessage extends ConsumerWidget {
  ChatMessage({Key? key, required this.text, required this.sender})
      : super(key: key);

  final String text;
  final String sender;

  RegExp regExp = RegExp(r'[@#\$%^&*()":{}|<>]');

  Color _randomColor() {
    var colors = [
      Colors.green,
      Colors.yellowAccent,
      Colors.orange,
      Colors.pink
    ];
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: sender == "user" ? AppColors.primaryColor : AppColors.botChatColor,
      child: Row(
        children: [
          sender == "user"
              ? Container(
                  height: 50,
                  width: 50,
                  color: AppColors.senderChatColor,
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
          sender == "user"
              ? Expanded(
                  child: Text(
                    text.trim(),
                    textAlign: TextAlign.justify,
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
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(isCopiedProvider.notifier)
                                          .state = true;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                  'Copied to Clipboard!')));
                                      Clipboard.setData(
                                          ClipboardData(text: text));

                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        ref
                                            .read(isCopiedProvider.notifier)
                                            .state = false;
                                      });
                                    },
                                    tooltip: 'Copy to Clipboard!',
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
                                        style: TextStyle(color: _randomColor()),
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
                      ),
                    ),
        ],
      ),
    );
  }
}
