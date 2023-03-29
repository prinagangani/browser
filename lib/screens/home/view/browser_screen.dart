import 'package:browser/screens/home/provider/browserprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class Browserscreen extends StatefulWidget {
  const Browserscreen({Key? key}) : super(key: key);

  @override
  State<Browserscreen> createState() => _BrowserscreenState();
}

class _BrowserscreenState extends State<Browserscreen> {
  Browserprovider? browserproviderTrue;
  Browserprovider? browserproviderFalse;

  TextEditingController txtSearch = TextEditingController();

  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    // TODO: implement initState
    pullToRefreshController = PullToRefreshController(onRefresh: () {
      browserproviderTrue!.inAppWebViewController!.reload();
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    browserproviderFalse = Provider.of(context, listen: false);
    browserproviderTrue = Provider.of(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          browserproviderTrue!.inAppWebViewController!.goBack();
                        },
                        child: Icon(Icons.arrow_back)),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          browserproviderTrue!.inAppWebViewController!.reload();
                        },
                        child: Icon(Icons.refresh)),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          browserproviderTrue!.inAppWebViewController!.goForward();
                        },
                        child: Icon(Icons.arrow_forward_outlined)),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.topCenter,
                    child: TextField(
                      controller: txtSearch,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    String newLink = txtSearch.text;
                    browserproviderTrue!.inAppWebViewController?.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(
                          "https://www.google.com/search?q=$newLink",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            LinearProgressIndicator(value: browserproviderTrue!.changedProgress ),

            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://www.google.com/")),
                onWebViewCreated: (controller) {
                  browserproviderTrue!.inAppWebViewController = controller;
                },
                onLoadError: (controller, url, code, message) {
                  browserproviderTrue!.inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  browserproviderTrue!.inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) {
                  browserproviderTrue!.inAppWebViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  browserproviderFalse!.onProgressChangged(progress/100);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
