import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// Demonstrates playing a one-shot animation on demand
class RiveTest extends StatefulWidget {
  const RiveTest({Key? key}) : super(key: key);

  @override
  State<RiveTest> createState() => _RiveTestState();
}

class _RiveTestState extends State<RiveTest> {
  Artboard? _riveArtboard;
  SMIInput<bool>? _start;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/switch.riv').then((value) async {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;
      // Switch 为你定义式状态机名称
      var controller = StateMachineController.fromArtboard(artboard, 'Switch');
      if (controller != null) {
        artboard.addController(controller);
        _start = controller.findInput('isDark');
        // print(_start?.value);
      }
      setState(() => _riveArtboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('RiveExample'),
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _start?.value = !_start!.value;
              // print(_controller.isActive);
            });
          },
          child: Center(
            // child: RiveAnimation.asset(
            //   'assets/dark-switch.riv',
            //   animations: _day ? ['idllOff'] : ['idllOn'],
            //   fit: BoxFit.contain,
            //   // controllers: [_controller],
            // ),
            child: _riveArtboard == null
                ? const CircularProgressIndicator()
                : Rive(artboard: _riveArtboard!),
          ),
        ));
  }
}
