import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:chat_gpt/app/shared/views/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Theme.of(context).bottomAppBarTheme.color,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: CustomTextField(
              textEditingController: textEditingController,
              onChanged: (val) {}),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Image.asset(AssetStrings.gptIcon),
        ],
      ),
    );
  }
}
