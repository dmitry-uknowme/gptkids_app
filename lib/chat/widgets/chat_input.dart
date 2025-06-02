import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:provider/provider.dart';
import '../chat_provider.dart';

class ChatInput extends StatefulWidget {
  final void Function(String) onMessageSend;
  const ChatInput({super.key, required this.onMessageSend});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = controller.text;
    widget.onMessageSend(text);
    // Provider.of<ChatProvider>(context, listen: false).sendMessage(text);
    // controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    var replyActions = [
      ChatReplyAction(
        label: 'Объясни еще раз',
        onTap: () {
          controller.text = 'Объясни еще раз';
          _send();
        },
      ),
      ChatReplyAction(
        label: 'Другие формулы',
        onTap: () {
          controller.text = 'Другие формулы';
          _send();
        },
      ),
      ChatReplyAction(
        label: 'Задача посложнее',
        onTap: () {
          controller.text = 'Задача посложнее';
          _send();
        },
      ),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                transitionBuilder:
                    (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                        child: child,
                      ),
                    ),
                child:
                    controller.text.isEmpty
                        ? Row(
                          key: ValueKey('icons-visible'),
                          children: [
                            IconButton(
                              icon: Icon(Icons.mic_rounded, color: Colors.grey),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.attach_file, color: Colors.grey),
                              onPressed: () {},
                            ),
                          ],
                        )
                        : SizedBox(key: ValueKey('icons-hidden')),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Напиши сообщение...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: AppColors.primary),
                onPressed: () => _send(),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children:
                  replyActions.map((suggestion) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          backgroundColor: AppColors.lightPrimary,
                          side: const BorderSide(color: AppColors.lightPrimary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: suggestion.onTap,
                        child: Text(
                          suggestion.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatReplyAction {
  final String label;
  final VoidCallback onTap;

  ChatReplyAction({required this.label, required this.onTap});
}
