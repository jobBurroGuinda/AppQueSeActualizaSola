import 'package:flutter/material.dart';
import 'dart:async';

/*
  All credits to RetroPortal Studio
  https://youtu.be/a0RG0sxfSjk
  https://www.youtube.com/@RetroPortalStudio
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ActualizacionApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHome(),
    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome() : super();
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with WidgetsBindingObserver {
  int count = 0;
  late Timer timer;
  bool active = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(active){
        setState((){
          count++;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        active = true;
        print("app is resumed");
        break;
      case AppLifecycleState.inactive:
        print("app is inactive");
        active = false;
        break;
      case AppLifecycleState.detached:
        print("app is detached");
        break;
      case AppLifecycleState.paused:
        active = false;
        print("app is paused");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Application Life Cycle',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
            '$count',
          style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}