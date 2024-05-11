import 'package:flutter/material.dart';

class MachineCardWidget extends StatelessWidget {
  const MachineCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
        semanticContainer: true,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('Machine Card'),
        ),
      );
  }
}
