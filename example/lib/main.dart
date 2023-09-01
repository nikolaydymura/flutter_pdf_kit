import 'package:flutter/material.dart';

import 'package:flutter_pdf_kit/flutter_pdf_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const _asset =
    String.fromEnvironment('DEMO_PDF', defaultValue: 'assets/dummy.pdf');

class _MyAppState extends State<MyApp> {
  CupertinoPdfViewController? controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.blue.withOpacity(0.4),
                splashColor: Colors.grey.withOpacity(0.05),
                child: Icon(Icons.arrow_back,
                  color: Colors.white.withOpacity(0.8),
                ),
                onPressed: () {
                  controller?.goToPreviousPage();
                },
              ),
              FloatingActionButton(
                backgroundColor: Colors.blue.withOpacity(0.4),
                splashColor: Colors.grey.withOpacity(0.05),
                child: Icon(Icons.arrow_forward,
                color: Colors.white.withOpacity(0.8),
                ),
                onPressed: () {
                  controller?.goToNextPage();
                },
              ),
            ],
          ),
          body: CupertinoPdfView.asset(
          _asset,
          onReady: (c) {
            controller = c;
          },
        ),
      ),
    );
  }
}
