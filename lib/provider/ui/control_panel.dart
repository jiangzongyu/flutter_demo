import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/logo_model.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogoModel>();

    print('ControlPanel rebuild');
    return Card(
      margin: const EdgeInsets.all(32.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Flip X:'),
                Switch(
                  value: model.flipX,
                  onChanged: (bool value) => model.flipX = value,
                ),
                const Text('Flip Y:'),
                Switch(
                  value: model.flipY,
                  onChanged: (bool value) => model.flipY = value,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Size'),
                Slider(
                  min: 50,
                  max: 300,
                  value: model.size,
                  onChanged: (double value) => model.size = value,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
