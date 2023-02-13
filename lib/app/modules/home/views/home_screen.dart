import 'dart:async';

import 'package:chat_gpt/app/modules/home/domain/service/chat_bot_service.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_app_bar.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_box_adapter.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_header.dart';
import 'package:chat_gpt/app/shared/views/widgets/text_form.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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
    try {
      final request = CompleteReq(
          prompt: 'prompt', model: kTranslateModelV3, max_tokens: 200);
      streamSubscription = chatGpt!
          .builder("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")
          .onCompleteStream(request: request)
          .listen((response) {
        ChatMessage botMessage =
            ChatMessage(text: response!.choices[0].text, sender: "bot");
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
                text:
                    'Hello there! i am a Chatbot built by Godson, how can i help you today?',
                sender: "bot"));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void sendMessage() {
    try {
      ChatMessage message =
          ChatMessage(text: textEditingController.text, sender: "user");
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
    } catch (e) {
      debugPrint(e.toString());
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
                onChanged: (val) {
                  // textEditingController.text = val;
                }),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              const CustomSliverAppBar(),

              /// i don't need this feature for now
              // CustomSliverPersistentHeader(),
              CustomSliverToBoxAdapter(
                messages: messages,
              ),
            ]),
      ),
    );
  }
}

// class PersonLocationProvider extends ChangeNotifier {
//   StreamController<CompleteRes?> currentLocation = StreamController.broadcast();
//
//   ChatGPT chatGPT = ChatGPT.instance;
//
//   PersonLocationProvider() {
//     _init();
//   }
//
//   _init() {
//     currentLocation.addStream(chatGPT
//         .builder("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")
//         .onCompleteStream(request: request));
//   }
// }
//
// final locationProvider = ChangeNotifierProvider<PersonLocationProvider>((ref) {
//   return PersonLocationProvider();
// });
//
// final locationStreamProvider = StreamProvider.autoDispose<LocationData>(
//   (ref) {
//     ref.maintainState = true;
//     final stream = ref.read(locationProvider).currentLocation.stream;
//     return stream;
//   },
// );
