import 'package:queroobras_mobile/mvvm/screens/dashboard/order/sucess_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../const/export.dart';

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
    final String targetUrl = "https://queroobras.popopipo.com/api/order/";
    final String targetUrlService = "https://queroobras.popopipo.com/api/service/";
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _loadingProgress = progress;
              });
            }
          },
          // 1. Logs every time a new page starts loading (useful for redirects)
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          // 2. Logs when a page has finished loading
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },

          // 3. Optional: Intercept navigation attempts before they happen
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('Allowing navigation to: ${request.url}');
            if (request.url.startsWith(targetUrl)) {
            Get.off(() => const SuccessScreen());

              // Example: Close the WebView if the payment status is reached
              // Navigator.pop(context);

              return NavigationDecision
                  .prevent; // Prevent the webview from actually loading the API raw data
            }
            if (request.url.startsWith(targetUrlService)) {
            Get.off(() => const SuccessScreen());

              // Example: Close the WebView if the payment status is reached
              // Navigator.pop(context);

              return NavigationDecision
                  .prevent; // Prevent the webview from actually loading the API raw data
            }
            return NavigationDecision.navigate;
          },
        ),
      )
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
