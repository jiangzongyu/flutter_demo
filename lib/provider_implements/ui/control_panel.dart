import 'package:flutter/material.dart';

import '../model/logo_model.dart';
import '../model/change_notifier_provider.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = ChangeNotifierProvider.of<LogoModel>(context);
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
