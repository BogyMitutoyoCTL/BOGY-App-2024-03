import 'package:flutter/material.dart';

import 'MainMenu.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 84, 152, 215),
      appBar: AppBar(
        title: Text("hallo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(style: TextStyle(fontSize: 30), "Welcome to"),
            Text(style: TextStyle(fontSize: 30), "BlueTemp"),
            Container(
              height: 50,
            ),
            Center(
                child: Image.asset(
                    height: 450, scale: 3, 'assets/Images/BlueTempAppIco.png')),
            Container(
              height: 40,
            ),
            ElevatedButton(
                onPressed: Main_Menu,
                child: Text("Get Started"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 3, 4, 8),
                    backgroundColor: Color.fromARGB(255, 135, 175, 224),
                    elevation: 5,
                    shadowColor: Colors.black)),
          ],
        ),
      ),
    );
  }

  void Main_Menu() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MainMenu()));
  }
}
