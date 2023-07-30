import 'package:flutter/material.dart';

class ReorderableListViewTest extends StatefulWidget {
  const ReorderableListViewTest({super.key});

  @override
  State<ReorderableListViewTest> createState() =>
      _ReorderableListViewTestState();
}

class _ReorderableListViewTestState extends State<ReorderableListViewTest> {
  final boxes = [
    Box(color: Colors.blue[100], key: UniqueKey()),
    Box(color: Colors.blue[300], key: UniqueKey()),
    Box(color: Colors.blue[500], key: UniqueKey()),
    Box(color: Colors.blue[700], key: UniqueKey()),
    Box(color: Colors.blue[900], key: UniqueKey()),
  ];

  _shuffle() {
    setState(() {
      boxes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReorderableListView拖拽'),
      ),
      body: Center(
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            print('move $oldIndex to $newIndex');
            if (newIndex > oldIndex) newIndex--;
            final box = boxes.removeAt(oldIndex);
            boxes.insert(newIndex, box);
          },
          children: boxes,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        tooltip: 'refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Color? color;

  const Box({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 50,
      height: 50,
      color: color,
    );
  }
}
