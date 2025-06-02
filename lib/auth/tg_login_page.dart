import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_telegram_login/flutter_telegram_login.dart';

class TelegramLoginPage extends StatefulWidget {
  const TelegramLoginPage({super.key});

  @override
  State<TelegramLoginPage> createState() => _TelegramLoginPageState();
}

class _TelegramLoginPageState extends State<TelegramLoginPage> {
  late final WebViewController _webViewController;
  final String BOT_ID = "7687565816";
  final String BOT_DOMAIN = "dev.ariel.gptkids.online";
  late TelegramLogin telegramLogin;
  // final TelegramLogin telegramLogin = TelegramLogin("", BOT_ID, BOT_DOMAIN);

  // @override
  // void initState() {
  //   super.initState();

  //   _webViewController =
  //       WebViewController()
  //         ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //         ..addJavaScriptChannel(
  //           'TelegramLogin',
  //           onMessageReceived: (message) {
  //             final telegramData = message.message;
  //             print("Telegram user data: $telegramData");
  //             // Здесь можно отправить telegramData на backend
  //           },
  //         )
  //         ..loadRequest(
  //           Uri.parse('https://dev.ariel.gptkids.online/api/tg/test'),
  //         );
  // }

  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text('Вход через Telegram')),
  //       body: WebViewWidget(controller: _webViewController),
  //     );
  //   }
  // }
  @override
  void initState() {
    super.initState();
    telegramLogin = TelegramLogin("+79867023170", BOT_ID, BOT_DOMAIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход через Telegram')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: telegramLogin.loginTelegram,
              child: const Text("loginTelegram"),
            ),
            ElevatedButton(
              onPressed: () async {
                var success = await telegramLogin.checkLogin();
                print(success);
              },
              child: const Text("checkLogin"),
            ),
            ElevatedButton(
              onPressed: () async {
                var data = await telegramLogin.getData();
                print(data);
                if (data) {
                  print(telegramLogin.userData);
                }
              },
              child: const Text("getData"),
            ),
            ElevatedButton(
              onPressed: () async {
                await telegramLogin.telegramLaunch();
              },
              child: const Text("openTelegram"),
            ),
          ],
        ),
      ),
    );
  }
}
