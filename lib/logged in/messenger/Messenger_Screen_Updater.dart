import 'package:flutter/material.dart';
import 'package:test_app/logged in/messenger/Main_Messenger_Screen.dart';
import 'package:test_app/logged in/messenger/Chat_Screen.dart';

class MessengerScreenUpdater extends StatefulWidget {
  const MessengerScreenUpdater({super.key});
  @override
  State<MessengerScreenUpdater> createState() {
    return _MessengerScreenUpdaterState();
  }
}

class _MessengerScreenUpdaterState extends State<MessengerScreenUpdater> {
  Widget activeScreen = const Text('data');
  @override
  void initState() {
    activeScreen = MainMessengerScreen(onOpenChat: _onOpenChat);
    super.initState();
  }

  void _onOpenChat(String name) {
    activeScreen = ChatScreen(name: name);
  }

  @override
  Widget build(context) {
    return activeScreen;
  }
}
