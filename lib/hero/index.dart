import 'package:flutter/material.dart';
import './detail_screen.dart';

class HeroTest extends StatelessWidget {
  const HeroTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(2, (index) {
          final path = 'assets/${index + 1}.jpeg';
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(path: path);
              }));
            },
            child: Hero(
              tag: path,
              child: Image.asset(path),
            ),
          );
        }),
      ),
    );
  }
}
