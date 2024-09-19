import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xetzgpt/pages/chat_page.dart';
import 'package:xetzgpt/services/chat_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ChatProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'XetzGPT',
      debugShowCheckedModeBanner: false,
      home: const ChatPage(),
    );
  }
}
