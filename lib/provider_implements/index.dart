import 'package:flutter/material.dart';

import 'ui/logo.dart';
import 'ui/control_panel.dart';
import 'model/logo_model.dart';
import 'model/change_notifier_provider.dart';

class ProviderImplements extends StatefulWidget {
  const ProviderImplements({super.key});

  @override
  State<ProviderImplements> createState() => _ProviderImplementsState();
}

class _ProviderImplementsState extends State<ProviderImplements> {
  @override
  Widget build(BuildContext context) {
    print('ProviderTest rebuild');
    return ChangeNotifierProvider(
      create: () => LogoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider实现'),
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
