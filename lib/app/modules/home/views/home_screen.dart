import 'dart:async';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/chat_view.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_app_bar.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:chat_gpt/app/shared/views/widgets/text_form.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isTyping = StateProvider((ref) => false);

/// this is the first and home screen of the application

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
                  /// send a message
                  sendMessage();
                },
                onFieldSubmitted: (val) {
                  /// send a message
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

  var t = dotenv.env['API_KEY'];

  /// listen to bot function
  void listenToBot() {
    final request = CompleteReq(
        prompt: AppStrings.prompt, model: kTranslateModelV3, max_tokens: 200);
    streamSubscription = chatGpt!
        .builder(t!)
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
          const ChatMessage(
              text: AppStrings.botWelcomeMessage, sender: AppStrings.bot));
    });
  }

  ///send a message function
  void sendMessage() {
    if (textEditingController.text.isNotEmpty) {
      ChatMessage message = ChatMessage(
          text: textEditingController.text, sender: AppStrings.user);
      ref.read(isTyping.notifier).state = true;

      setState(() {
        messages.insert(0, message);
      });
      textEditingController.clear();
      final request = CompleteReq(
          prompt: message.text, model: kTranslateModelV3, max_tokens: 200);

      chatGpt!.builder(t!).onCompleteStream(request: request);

      Future.delayed(const Duration(seconds: 30), () {
        // ignore: unnecessary_null_comparison
        if (ref.read(isTyping.notifier).state) {
          ref.read(isTyping.notifier).state = false;
          setState(() {
            messages.insert(
                0,
                const ChatMessage(
                    text: AppStrings.unableToReply, sender: AppStrings.bot));
          });
        } else {}
      });
    }
  }
}
