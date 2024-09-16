import 'package:flutter/material.dart';
import 'package:xetzgpt/pages/chat_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
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
