import 'package:bluetemp/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context).appname),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(style: TextStyle(fontSize: 30), AppLocalizations.of(context).welcome),
            Container(
              height: 50,
            ),
            Center(child: Image.asset(height: 450, scale: 3, 'assets/Images/BlueTempAppIco.png')),
            Container(
              height: 40,
            ),
            ElevatedButton(
                onPressed: Main_Menue,
                child: Text(AppLocalizations.of(context).getStarted),
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

  void Main_Menue() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainMenu()));
  }
}
