import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  // Use a more descriptive name, like WebViewScreen
  const WebViewScreen({super.key, required this.url});
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  // 1. Controller instance
  late final WebViewController _controller;

  // 2. State variable for tracking loading progress (0 to 100)
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    // 3. Initialize the controller in initState
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // 4. Set the onProgress callback to update the state
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update the state with the current loading progress
            if (mounted) {
              setState(() {
                _loadingProgress = progress;
              });
            }
          },
          // You can add other handlers here, like onPageFinished, onError, etc.
        ),
      )
      // 5. Load the initial request
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Loading Web Content...'),
      //   // Optional: Show the progress bar in the AppBar
      //   bottom: _loadingProgress < 100
      //       ? PreferredSize(
      //           preferredSize: const Size.fromHeight(4.0),
      //           child: LinearProgressIndicator(
      //             value: _loadingProgress / 100.0,
      //             backgroundColor: Colors.grey[200],
      //             valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
      //           ),
      //         )
      //       : null, // Hide the progress bar when loading is complete
      // ),
      body: Stack(
        children: <Widget>[
          // 6. The actual WebView widget
          WebViewWidget(controller: _controller),

          // 7. Conditional Loading Indicator in the center (optional)
          if (_loadingProgress < 100 && _loadingProgress > 0)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
