import 'package:flutter/material.dart';
import 'package:flutter_jiang_demo/provider/model/logo_model.dart';
import 'package:provider/provider.dart';

import 'ui/control_panel.dart';
import 'ui/logo.dart';

class ProviderTest extends StatefulWidget {
  const ProviderTest({super.key});

  @override
  State<ProviderTest> createState() => _ProviderTestState();
}

class _ProviderTestState extends State<ProviderTest> {
  @override
  Widget build(BuildContext context) {
    print('ProviderTest rebuild');
    return ChangeNotifierProvider(
      create: (BuildContext context) => LogoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ProviderTest'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              ControlPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
