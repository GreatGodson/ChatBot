import 'package:chat_gpt/app/modules/home/views/home_screen.dart';
import 'package:chat_gpt/app/shared/helpers/dimensions.dart';
import 'package:chat_gpt/app/shared/views/widgets/chat_view.dart';
import 'package:chat_gpt/app/shared/views/widgets/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isCopiedProvider = StateProvider((ref) => false);

class CustomSliverToBoxAdapter extends ConsumerStatefulWidget {
  const CustomSliverToBoxAdapter({Key? key, required this.messages})
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
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),

      /// height: 500,
      height: context.deviceHeight(0.8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                // padding: const EdgeInsets.only(bottom: 40),
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
