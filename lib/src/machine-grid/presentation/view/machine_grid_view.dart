import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/src/machine-grid/presentation/view/machine_card_view.dart';

import '../../../../common/logging.dart';
import '../../../../providers/machine.provider.dart';
import '../../../../shared/widget/neumorphism/neumorphism_container_widget.dart';
import '../provider/image_provider.dart';
import '../widget/machine_add_dialog_widget.dart';

final Logging log = Logging('machine_grid_view.dart');

class MachinePlanningView extends ConsumerStatefulWidget {
  const MachinePlanningView({super.key});

  @override
  ConsumerState<MachinePlanningView> createState() =>
      _MachinePlanningViewState();
}

class _MachinePlanningViewState extends ConsumerState<MachinePlanningView> {
  @override
  void initState() {
    super.initState();
    reloadMachines();
  }

  void reloadMachines() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(machineProvider.notifier).init();
      ref.watch(imageUpdateProvider);
    });
  }

  void showAddMachineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddMachineDialogWidget();
      },
    ).then((result) {
      // Überprüfen, ob der Dialog true zurückgegeben hat (Maschine erfolgreich hinzugefügt)
      if (result == true) {
        reloadMachines(); // Grid neu laden
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 400).floor();
    final machinesAsync = ref.watch(machineProvider);

    return SizedBox.expand(
        child: Padding(
      padding: const EdgeInsets.all(30),
      child: NeumorphismContainerWidget(
        distance: 5,
        blur: 10,
        inset: true,
        borderRadius: 20,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: machinesAsync.when(
            data: (machines) => GridView.builder(
              itemCount: machines.length + 1,
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(20),
                    child: index == 0
                        ? const MachineCardView(
                            isAddCard: true,
                          )
                        : MachineCardView(
                            imageLocalPath:
                                machines[index - 1].imagesLocationPath,
                          ));
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.9,
              ),
            ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    ));
  }
}
