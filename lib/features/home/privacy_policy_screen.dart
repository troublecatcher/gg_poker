import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gg_poker/main.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SafeArea(
        bottom: false,
        child: privacyPolicy != null && privacyPolicy != ''
            ? InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(privacyPolicy!),
                ),
              )
            : const Center(
                child: Text('No privacy policy'),
              ),
      ),
    );
  }
}
