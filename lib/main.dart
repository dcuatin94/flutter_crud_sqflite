import 'package:flutter/material.dart';
import 'package:flutter_curd/view/404.dart';
import 'package:flutter_curd/view/home_screen.dart';
import 'package:flutter_curd/view/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

const darkBlueColor = Color(0xff486579); //App theme

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _routes = {
    '/': (context) => const WelcomeScreen(),
    '/home': (context) => const MyHomePage(
          title: "CRUD COMPUTADORAS",
        )
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOME SMART TECH',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: _routes,
      // onGenerateInitialRoutes: (settings) => MaterialPageRoute(builder: (context) => const PageNotFound()),
      theme: ThemeData(
        // primaryColor: Colors.orange,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

//Add home page
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  String get title => "COMPUTADORAS - CRUD";

  @override
  State<MyHomePage> createState() => MyHomePageState();
}
