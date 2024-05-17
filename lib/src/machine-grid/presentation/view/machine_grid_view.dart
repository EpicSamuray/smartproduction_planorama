import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_button_widget.dart';
import 'package:smartproduction_planorama/src/machine-grid/presentation/view/machine_card_view.dart';

import '../../../../common/logging.dart';
import '../../../../providers/machine.provider.dart';
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
  bool showOverlay = false;

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

  void deleteMachines(String fileId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageDeleterProvider(fileId));
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
    return Column(
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(top: 30)),
        SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: NeumorphismButtonWidget(
                    onPressed: () {
                      reloadMachines();
                    },
                    onlyIcon: true,
                    blur: NeumorphismConstants.blur,
                    distance: NeumorphismConstants.distance,
                    color: HexColors.primaryColor.shade900,
                    borderRadius: 20,
                    child: const Icon(Icons.refresh, size: 40),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: NeumorphismButtonWidget(
                      onPressed: () {
                        setState(() {
                          showOverlay = !showOverlay;
                          log.logDebug('Overlay: $showOverlay');
                        });
                      },
                      onlyIcon: true,
                      blur: NeumorphismConstants.blur,
                      distance: NeumorphismConstants.distance,
                      color: HexColors.primaryColor.shade900,
                      borderRadius: 20,
                      child:
                          const Icon(Icons.delete, size: 40, color: Colors.red),
                    )),
              ],
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: machinesAsync.when(
              data: (machines) => GridView.builder(
                itemCount: machines.length + 1,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.all(20),
                      child: index == 0
                          ? NeumorphismButtonWidget(
                              distance: NeumorphismConstants.distance,
                              blur: NeumorphismConstants.blur,
                              color: HexColors.primaryColor.shade900,
                              borderRadius: 20,
                              onlyIcon: true,
                              onPressed: () {
                                showAddMachineDialog(context);
                              },
                              icon: Icon(
                                Icons.add,
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                            )
                          : Stack(
                              children: [
                                MachineCardView(
                                  progressInPercent: 95,
                                  imageLocalPath:
                                      machines[index - 1].imagesLocationPath,
                                ),
                                if (showOverlay)
                                  Listener(
                                    onPointerDown: (event) {
                                      setState(() {
                                        log.logDebug(
                                            machines[index - 1].fileId);
                                        deleteMachines(
                                            machines[index - 1].fileId);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.delete,
                                            color: Colors.white, size: 40),
                                      ),
                                    ),
                                  )
                              ],
                            ));
                },
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.9,
                ),
              ),
              error: (err, stack) => Text('Error: $err'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        )
      ],
    );
  }
}
