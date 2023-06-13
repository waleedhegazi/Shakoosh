import 'package:flutter/material.dart';

class MainMessengerScreen extends StatelessWidget {
  final void Function(String name) onOpenChat;
  const MainMessengerScreen({required this.onOpenChat, super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(),
    );
  }
}
