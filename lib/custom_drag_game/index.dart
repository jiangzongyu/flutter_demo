import 'package:flutter/material.dart';

class CustomDrag extends StatefulWidget {
  const CustomDrag({super.key});

  @override
  State<CustomDrag> createState() => _CustomDragState();
}

class _CustomDragState extends State<CustomDrag> {
  final _colors = [
    Colors.blue[100],
    Colors.blue[300],
    Colors.blue[500],
    Colors.blue[700],
    Colors.blue[900],
  ];

  late int _slot;

  _shuffle() {
    setState(() {
      _colors.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义拖拽颜色游戏'),
      ),
      body: Listener(
        onPointerMove: (event) {
          final x = event.position.dx;
          // print(x);
          if (x > (_slot + 1) * Box.width) {
            if (_slot == _colors.length - 1) return;
            setState(() {
              final c = _colors[_slot];
              _colors[_slot] = _colors[_slot + 1];
              _colors[_slot + 1] = c;
              _slot++;
            });
          } else if (x < _slot * Box.width) {
            if (_slot == 0) return;
            setState(() {
              final c = _colors[_slot];
              _colors[_slot] = _colors[_slot - 1];
              _colors[_slot - 1] = c;
              _slot--;
            });
          }
        },
        child: Stack(
          children: List.generate(_colors.length, (index) {
            return Box(
              color: _colors[index] ?? Colors.blue,
              x: index * Box.width,
              y: 200,
              key: ValueKey(_colors[index]),
              onDrag: (Color color) {
                final index = _colors.indexOf(color);
                // print(index);
                _slot = index;
              },
            );
          }),
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
  static const width = 50.0;
  static const height = 50.0;
  static const margin = 2.0;
  final Color color;
  final double x, y;
  final Function(Color) onDrag;

  const Box({
    super.key,
    required this.color,
    required this.x,
    required this.y,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width - margin * 2,
      height: height - margin * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      left: x,
      top: y,
      child: Draggable(
        onDragStarted: () => onDrag(color),
        feedback: container,
        childWhenDragging: Visibility(
          visible: false,
          child: container,
        ),
        child: container,
      ),
    );
  }
}
