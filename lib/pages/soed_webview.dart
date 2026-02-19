import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:my_app/core/constants.dart';

class SoedWebView extends StatefulWidget {
  const SoedWebView({super.key});

  @override
  State<SoedWebView> createState() => _SoedWebViewState();
}

class _SoedWebViewState extends State<SoedWebView> {
  late final WebViewController _controller;
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://soed.ku.edu.np/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KUSOED Website'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.browser_updated),
            onPressed: () {
               // Open in external browser if needed, but for now just refresh
               _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loadingProgress < 100)
            LinearProgressIndicator(
              value: _loadingProgress / 100.0,
              backgroundColor: Colors.white,
              color: AppColors.primaryCrimson,
              minHeight: 3,
            ),
        ],
      ),
    );
  }
}
