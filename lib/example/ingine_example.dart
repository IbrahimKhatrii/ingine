import 'package:flutter/material.dart';

import '../engine.dart';

void main() => IEngine.run(const Application());

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Placeholder());
}
