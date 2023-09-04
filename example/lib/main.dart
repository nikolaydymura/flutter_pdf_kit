import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  TextEditingController pageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    pageController;
  }

  @override
  void dispose() {
    controller?.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('Plugin example app'),
          ),
          actions: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 24, maxWidth: 50),
              child: TextField(
                controller: pageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[0-9]*'),
                  ),
                ],
                decoration: InputDecoration(
                  fillColor: Colors.white.withOpacity(0.4),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 70),
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (pageController.text.isNotEmpty) {
                      controller?.goToPage(int.parse(pageController.text));
                    }
                    pageController.clear();
                  });
                },
                child: const Text(
                  'Open page',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.blue.withOpacity(0.4),
              splashColor: Colors.grey.withOpacity(0.05),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white.withOpacity(0.8),
              ),
              onPressed: () {
                controller?.goToPreviousPage();
              },
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue.withOpacity(0.4),
              splashColor: Colors.grey.withOpacity(0.05),
              child: Icon(
                Icons.arrow_forward,
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
