import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'dialog_webview.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy & Policy"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('https://venturo.id'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            const DialogWebview(),
          );
        },
        child: const Icon(Icons.open_in_new),
      ),
    );
  }
}
