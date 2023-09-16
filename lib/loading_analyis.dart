import 'package:flutter/material.dart';

class Analysis_Loading extends StatefulWidget {
  const Analysis_Loading({super.key});

  @override
  State<Analysis_Loading> createState() => _Analysis_LoadingState();
}

class _Analysis_LoadingState extends State<Analysis_Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Container(
          child: Column(children: [Text('Loading Pop Ups to be shown')]),
        )),
      ),
    );
  }
}
