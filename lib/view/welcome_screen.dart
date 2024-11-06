import 'package:flutter/material.dart';
import 'package:flutter_curd/widgets/RoundedImageWithShadow.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Smart Tech",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedImageWithShadow(imagePath: "assets/images/smartech.png"),
            SizedBox(
              height: 20,
            ),
            Text(
              'Bienvenidos a Smart Tech!',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Aprovecha nuestros descuentos por el mes de noviembre',
              style: TextStyle(fontSize: 20, color: Colors.black54),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
