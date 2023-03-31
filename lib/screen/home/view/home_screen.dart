import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:webview/screen/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController txtsearch = TextEditingController();
  HomeProvider? HPTrue, HPFalse;

  @override
  Widget build(BuildContext context) {
    HPTrue = Provider.of<HomeProvider>(context, listen: true);
    HPFalse = Provider.of<HomeProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black,width: 2),
              ),
              child: TextField(
                controller: txtsearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: () {
                      var newLink = txtsearch.text;

                      HPTrue!.inAppWebViewController!.loadUrl(
                        urlRequest: URLRequest(url: Uri.parse(
                            "https://www.google.com/search?q=$newLink"),),);
                    },
                    icon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.grey.shade600,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                LinearProgressIndicator(
                  value: HPTrue!.webProgress,
                  color: Colors.black87,
                ),
                SizedBox(height: 5,),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: Uri.parse("https://www.google.com/"),
                    ),
                    onWebViewCreated: (controller) {
                      HPTrue!.inAppWebViewController = controller;
                    },
                    onLoadError: (controller, url, code, message) {
                      HPTrue!.inAppWebViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      HPTrue!.inAppWebViewController = controller;
                    },
                    onLoadStop: (controller, url) {
                      HPTrue!.inAppWebViewController = controller;
                    },
                    onProgressChanged: (controller, progress) {
                      HPFalse!.progressChange(progress / 100);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomSheet: Container(
          color: Colors.grey.shade600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  HPTrue!.inAppWebViewController!.goBack();
                },
                icon: Icon(Icons.arrow_back,color: Colors.white,),
              ),
              IconButton(
                onPressed: () {
                  HPTrue!.inAppWebViewController!.reload();
                },
                icon: Icon(Icons.refresh, color: Colors.white,),
              ),
              IconButton(
                onPressed: () {
                  HPTrue!.inAppWebViewController!.stopLoading();
                  },
                icon: Icon(Icons.close,color: Colors.white,),
              ),
              IconButton(
                onPressed: () {
                  HPTrue!.inAppWebViewController!.goForward();
                  },
                icon: Icon(Icons.arrow_forward,color: Colors.white,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
