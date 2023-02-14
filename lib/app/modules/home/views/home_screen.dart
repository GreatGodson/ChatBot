import 'dart:async';
import 'package:chat_gpt/app/shared/helpers/const.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/chat_view.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_app_bar.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:chat_gpt/app/shared/views/widgets/text_form.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isTyping = StateProvider((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController textEditingController;
  ChatGPT? chatGpt;
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    chatGpt = ChatGPT.instance;
    listenToBot();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    streamSubscription?.cancel();
    super.dispose();
  }

  List<ChatMessage> messages = [];

  void listenToBot() {
    final request = CompleteReq(
        prompt: AppStrings.prompt, model: kTranslateModelV3, max_tokens: 200);
    streamSubscription = chatGpt!
        .builder(apiKey)
        .onCompleteStream(request: request)
        .listen((response) {
      ChatMessage botMessage =
          ChatMessage(text: response!.choices[0].text, sender: AppStrings.bot);
      debugPrint(response.choices[0].text.toString());
      ref.read(isTyping.notifier).state = false;

      setState(() {
        messages.insert(0, botMessage);
      });
    });

    setState(() {
      messages.insert(
          0,
          ChatMessage(
              text: AppStrings.botWelcomeMessage, sender: AppStrings.bot));
    });
  }

  void sendMessage() {
    if (textEditingController.text.isNotEmpty) {
      ChatMessage message = ChatMessage(
          text: textEditingController.text, sender: AppStrings.user);
      ref.read(isTyping.notifier).state = true;

      Future.delayed(const Duration(seconds: 10), () {
        // ignore: unnecessary_null_comparison
        if (ref.read(isTyping.notifier).state) {
          ref.read(isTyping.notifier).state = false;
          setState(() {
            messages.insert(
                0,
                ChatMessage(
                    text:
                        'i\'m unable to reply to this at the moment 😭 call Godson! he built me!',
                    sender: "bot"));
          });
        } else {}
      });

      setState(() {
        messages.insert(0, message);
      });
      textEditingController.clear();
      final request = CompleteReq(
          prompt: message.text, model: kTranslateModelV3, max_tokens: 200);

      var t = chatGpt!
          .builder("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")
          .onCompleteStream(request: request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          elevation: 0.0,
          color: Theme.of(context).bottomAppBarTheme.color,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: CustomTextField(
                iconOnPressed: () {
                  sendMessage();
                },
                onFieldSubmitted: (val) {
                  sendMessage();
                },
                textEditingController: textEditingController,
                onChanged: (val) {}),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              const CustomSliverAppBar(),
              CustomSliverToBoxAdapter(
                messages: messages,
              ),
            ]),
      ),
    );
  }
}
