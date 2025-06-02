import 'package:flutter/material.dart';
import 'package:gptkids_app/chat/chat_page.dart';
import 'package:gptkids_app/chat/chat_provider.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatelessWidget {
  final Widget page;
  final List<ChangeNotifier> providers;

  PageLayout({super.key, required this.page, List<ChangeNotifier>? providers})
    : providers = [AppProvider()];

  Widget buildWithProviders() {
    // if (page.runtimeType == ChatPage) {
    //   if (!providers.any((p) => p.runtimeType == ChatProvider)) {
    //     providers.add(ChatProvider());
    //   }
    // }

    return MultiProvider(
      providers: [
        ...providers.map((provider) {
          return ChangeNotifierProvider(create: (_) => provider);
        }),
      ],
      child: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...providers.map((provider) {
          return ChangeNotifierProvider(create: (_) => provider);
        }),
      ],
      child: page,
    );
    // return buildWithProviders();
  }
}
