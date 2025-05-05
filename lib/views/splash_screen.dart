import 'package:flutter/material.dart';
import 'package:weather_app/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading();
  }

  Future<void> _loading() async {
    Future.delayed(Duration(seconds: 5), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [Colors.deepOrange, Colors.yellowAccent],
            stops: [0, 1],
          ),
        ),
        // child: Center(child: Text('Weather')),
      ),
    );
  }
}
