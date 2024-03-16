import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gg_poker/main.dart';

@RoutePage()
class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Use'),
      ),
      body: SafeArea(
        bottom: false,
        child: termsOfUse != null && termsOfUse != ''
            ? InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(termsOfUse!),
                ),
              )
            : const Center(
                child: Text('No terms of use'),
              ),
      ),
    );
  }
}
