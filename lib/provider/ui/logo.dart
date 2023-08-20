import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/logo_model.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogoModel>();
    print('logo rebuild');
    return Card(
      child: Transform.flip(
        flipX: model.flipX,
        flipY: model.flipY,
        child: FlutterLogo(size: model.size),
      ),
    );
  }
}
