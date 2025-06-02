import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gptkids_app/chat/widgets/chat_action.dart';
import 'package:gptkids_app/chat/widgets/chat_app_bar.dart';
import 'package:gptkids_app/common/widgets/page_layout.dart';
import 'package:gptkids_app/home/home_page.dart';
import 'package:gptkids_app/shared/api/message.dart';
import 'package:provider/provider.dart';
import 'chat_provider.dart';
import 'widgets/chat_message.dart';
import 'widgets/chat_input.dart';

class ChatPage extends StatefulWidget {
  final ChatActionModel defaultAction;
  const ChatPage({super.key, required this.defaultAction});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? aiResponse;
  late ChatProvider provider;
  final ScrollController scrollController = ScrollController();
  Timer? scrollThrottleTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<ChatProvider>(context, listen: false);
      // provider.addListener(_onProviderChanged);
      provider.refetchMessages();
      provider.setAction(widget.defaultAction);
      scrollToLastMessage();
    });
  }

  void scrollToLastMessage() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    scrollThrottleTimer?.cancel();
  }

  void onMessageSend(String text) {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    final actionName = provider.action?.name;
    if (actionName == null) {
      return;
    }
    provider.addMessage(
      MessageModel(type: "TEXT", content: text, role: Role.USER, fileUrl: ""),
    );
    final subscription = messageSendStream(actionName!, text)
        .listen((chunk) {
          setState(() {
            aiResponse = (aiResponse ?? '') + chunk;
          });

          scrollThrottleTimer ??= Timer(Duration(milliseconds: 200), () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollToLastMessage();
              scrollThrottleTimer = null;
            });
          });
        })
        .onDone(() {
          Future.microtask(() async {
            await provider.refetchMessages();
            setState(() {
              aiResponse = null;
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollToLastMessage();
            });
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context, listen: true);
    final selectedActionName = provider.action?.name;
    final messages = provider.messages;

    return Scaffold(
      appBar: ChatAppBar(
        onLogoPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ChatActionList(
              onActionSelected: (value) {
                provider.setAction(
                  DEFAULT_CHAT_ACTION_LIST.firstWhere(
                    (action) => action.name == value,
                  ),
                );
              },
              selectedActionName: selectedActionName ?? '',
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ...messages.map((message) {
                      return Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: ChatMessage(message: message),
                      );
                    }),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child:
                          aiResponse != null
                              ? ChatMessage(
                                message: MessageModel(
                                  type: "TEXT",
                                  content: aiResponse ?? "",
                                  fileUrl: "",
                                  role: Role.ASSISTANT,
                                ),
                              )
                              : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            ChatInput(onMessageSend: onMessageSend),
          ],
        ),
      ),
    );
  }
}
