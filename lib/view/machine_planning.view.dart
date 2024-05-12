import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/providers/file.picker.provider.dart';
import 'package:smartproduction_planorama/providers/storage.provider.dart';
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
                                        showAddMachineDialog(context, ref);
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

void showAddMachineDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: HexColors.primaryColor.shade300,
          title: const Text('Add Ressource', style: TextStyle(color: Colors.white)),
          content: SizedBox(
              width: 600,
              height: 400,
              child: Row(
                children: [
                  Expanded(
                      child: Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(filePickerProvider).when(
                              data: (Map<String, dynamic> data) {
                                if (data['file'] == null) {
                                  return DottedBorder(
                                    borderType: BorderType.RRect,
                                    dashPattern: const [20, 20, 20, 20],
                                    radius: const Radius.circular(15),
                                    color: HexColors.tertiaryColor.shade900,
                                    strokeWidth: 3,
                                    child: SizedBox.expand(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                        child: GestureDetector(
                                          onTap: () {
                                            log.logInfo('Upload image pressed');
                                            ref.read(filePickerProvider.notifier).pickFile();
                                          },
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.upload, size: 100),
                                              Text('Upload Image', style: TextStyle(color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.memory(data['file'] as Uint8List, width: 200),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          ref.read(filePickerProvider.notifier).pickFile();
                                        },
                                        child: const Text('ändern'),
                                      ),
                                    ],
                                  );
                                }
                              },
                              error: (Object error, StackTrace stackTrace) => Text('Error: $error'),
                              loading: () => const CircularProgressIndicator(),
                            );
                          }
                      )
                  ),
                  const SizedBox(width: 20),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(labelText: 'Machine Name'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ref.read(filePickerProvider.notifier).clearFile();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(filePickerProvider.notifier).state.when(
                  data: (Map<String, dynamic> file) {
                    log.logInfo('File: ${file['fileName']}');

                    if (file['file'] != null) {
                      log.logDebug('Uploading file: ${file.length}');
                      ref.read(storageRepositoryProvider).uploadFile(
                        file['fileName'] as String,
                        AppwriteConstant.collectionID,
                        file['file'] as Uint8List,
                      );
                    }
                  },
                  error: (Object error, StackTrace stackTrace) => log.logError('Error: $error', stackTrace),
                  loading: () => log.logDebug('Loading'),
                );
                ref.read(filePickerProvider.notifier).clearFile();
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

