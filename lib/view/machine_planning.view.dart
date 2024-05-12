import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/view/widget/machine.card.widget.dart';
import 'package:smartproduction_planorama/view/widget/neumorphism.container.widget.dart';

import '../common/logging.dart';
import '../providers/machine.provider.dart';

final Logging log = Logging('machine_planning.view.dart');

class MachinePlanningView extends ConsumerStatefulWidget {
  const MachinePlanningView({super.key});

  @override
  ConsumerState<MachinePlanningView> createState() =>
      _MachinePlanningViewState();
}

class _MachinePlanningViewState extends ConsumerState<MachinePlanningView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: NeumorphismContainerWidget(
          distance: 3,
          blur: 3,
          borderRadius: 15,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer(builder: (context, ref, child) {
                final machines = ref.watch(machineProvider);
                return machines.when(
                    data: (machines) {
                      return GridView.builder(
                        itemCount: machines.length + 1,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(20),
                              child: index == 0
                                  ? MachineCardWidget(
                                      onPressed: () {
                                        log.logInfo('Add machine pressed');
                                        showAddMachineDialog(context);
                                      },
                                      distance: 3,
                                      blur: 3,
                                  isAddCard: true,
                              )
                                  : MachineCardWidget(
                                      filePath: machines[index - 1]
                                          .imagesLocationPath,
                                      distance: 3,
                                      blur: 3,
                                      onPressed: () {
                                        log.logInfo(
                                            'Machine ${machines[index - 1].imageId} pressed');
                                      },
                                    ));
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.8,
                        ),
                      );
                    },
                    error: (err, stack) => Text('Error: $err'),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()));
              })),
        ),
      ),
    );
  }
}

void showAddMachineDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          title: const Text('Add Machine'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Machine Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Machine Description',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Machine Image',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      );
    },
  );
}
