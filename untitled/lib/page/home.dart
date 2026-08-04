
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Hello"),
      ),
      body: const Center(
        child: Text("body",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight(800),
          color: Colors.blue,
        ),
        ),
      ),
    );
  }
}
