import 'dart:math';

import 'package:flutter/material.dart';

// 运用globalKey 个人理解这里的globalKey类似vue中的ref
class UltimateDrag extends StatefulWidget {
  const UltimateDrag({super.key});

  @override
  State<UltimateDrag> createState() => _UltimateDragState();
}

class _UltimateDragState extends State<UltimateDrag> {
  // final _colors = [
  //   Colors.blue[100],
  //   Colors.blue[300],
  //   Colors.blue[500],
  //   Colors.blue[700],
  //   Colors.blue[800],
  // ];
  var _color = Colors.blue;
  List<Color> _colors = [];

  late int _slot;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  _shuffle() {
    _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _colors = List.generate(8, (index) => _color[(index + 1) * 100]!);
    setState(() {
      _colors.shuffle();
    });
  }

  _checkWinCondition() {
    List<double> lum = _colors.map((e) => e.computeLuminance()).toList();

    bool success = true;
    for (var i = 0; i < lum.length - 1; i++) {
      if (lum[i] > lum[i + 1]) {
        success = false;
        break;
      }
    }
    print(success ? 'win' : 'continue');
  }

  final _globalKey = GlobalKey();
  late double _offset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('终极版拖拽颜色游戏'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Text(
              'Welcome:',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 32),
            Container(
              width: Box.width - Box.margin * 2,
              height: Box.height - Box.margin * 2,
              decoration: BoxDecoration(
                color: _color[900],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: Box.margin * 2),
            Expanded(
              child: Listener(
                onPointerMove: (event) {
                  final y = event.position.dy - _offset;
                  // print(x);
                  // 从上往下拖拽
                  if (y > (_slot + 1) * Box.height) {
                    // 当位置为最后面的时候
                    if (_slot == _colors.length - 1) return;
                    setState(() {
                      final c = _colors[_slot];
                      _colors[_slot] = _colors[_slot + 1];
                      _colors[_slot + 1] = c;
                      _slot++;
                    });
                    //   从下往上拖拽
                  } else if (y < _slot * Box.height) {
                    // 当位置未最前面的时候
                    if (_slot == 0) return;
                    setState(() {
                      final c = _colors[_slot];
                      _colors[_slot] = _colors[_slot - 1];
                      _colors[_slot - 1] = c;
                      _slot--;
                    });
                  }
                },
                child: SizedBox(
                  width: Box.width,
                  child: Stack(
                    key: _globalKey,
                    children: List.generate(_colors.length, (index) {
                      return Box(
                        color: _colors[index],
                        x: 0,
                        y: index * Box.height,
                        onDrag: (Color color) {
                          final index = _colors.indexOf(color);
                          // print(index);
                          final renderBox = (_globalKey.currentContext
                              ?.findRenderObject() as RenderBox);
                          _offset = renderBox.localToGlobal(Offset.zero).dy;
                          print('on drag $index, offset = $_offset');
                          // 定义点击的时候是第几个
                          _slot = index;
                        },
                        onEnd: _checkWinCondition,
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
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
  static const width = 250.0;
  static const height = 50.0;
  static const margin = 2.0;
  final Color color;
  final double x, y;
  final Function(Color) onDrag;
  final Function() onEnd;

  Box({
    required this.color,
    required this.x,
    required this.y,
    required this.onDrag,
    required this.onEnd,
  }) : super(key: ValueKey(color));

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
        onDragEnd: (_) => onEnd(),
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
