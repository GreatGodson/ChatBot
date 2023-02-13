import 'dart:async';

import 'package:chat_gpt/app/modules/home/views/home_screen.dart';
import 'package:chat_gpt/app/shared/utils/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// my chatGPT API:KEY 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

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
