import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String path;
  const DetailScreen({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailScreen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: path,
              child: Image.asset(
                path,
                width: 100,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'xxxxx',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'aaaaaaaaa',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
