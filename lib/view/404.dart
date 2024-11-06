import 'package:flutter/material.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  _PageNotFound createState() => _PageNotFound();
}

class _PageNotFound extends State<PageNotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página no encontrada'),
      ),
      body: const Center(
        child: Text('404 Página no encontrada'),
      ),
    );
  }
}
