import 'package:chat_gpt/app/modules/home/views/home_screen.dart';
import 'package:chat_gpt/app/shared/utils/theme/theme_data.dart';
import 'package:flutter/material.dart';

// my chatGPT API:KEY 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
void main() {
  runApp(const MyApp());
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

// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// Future<String> generateText(String prompt) async {
//   String API_KEY = "YOUR_OPENAI_API_KEY";
//   String API_ENDPOINT = "https://api.openai.com/v1/engines/davinci/completions";
//
//   var response = await http.post(
//     API_ENDPOINT,
//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $API_KEY",
//     },
//     body: jsonEncode({
//       "prompt": prompt,
//       "max_tokens": 50,
//       "temperature": 0.5,
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     return data['choices'][0]['text'];
//   } else {
//     throw Exception("Failed to generate text");
//   }
// }
