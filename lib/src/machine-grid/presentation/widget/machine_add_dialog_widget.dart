import 'dart:typed_data';
import 'dart:ui';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/remote/machine_db_upload_dto.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/remote/machine_upload_dto.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/repo/machine_repository.dart';
import 'package:smartproduction_planorama/src/machine-grid/presentation/widget/file_picker_widget.dart';

import '../../../../common/constants.dart';
import '../../../../common/logging.dart';
import '../../data/dto/remote/machine_image_upload_dto.dart';
import '../provider/file_picker_provider.dart';

final Logging log = Logging('machine_add_dialog_widget.dart');

class AddMachineDialogWidget extends ConsumerStatefulWidget {
  const AddMachineDialogWidget({super.key});

  @override
  ConsumerState createState() => _AddMachineDialogWidgetState();
}

class _AddMachineDialogWidgetState
    extends ConsumerState<AddMachineDialogWidget> {
  final TextEditingController _machineNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: HexColors.primaryColor.shade300,
        title:
            const Text('Add Ressource', style: TextStyle(color: Colors.white)),
        content: SizedBox(
            width: 600,
            height: 400,
            child: Row(
              children: [
                const Expanded(child: FilePickerWidget()),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _machineNameController,
                    decoration:
                        const InputDecoration(labelText: 'Machine Name'),
                  ),
                ),
              ],
            )),
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
              addMachine();
              ref.read(filePickerProvider.notifier).clearFile();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void addMachine() async {
    final file = ref.read(filePickerProvider);
    file.when(
      data: (data) async {
        try {
          MachineDbUploadDto machineDbUploadDto = MachineDbUploadDto(
              machineName: _machineNameController.text, fileId: ID.unique());

          MachineImageUploadDto machineImageUploadDto = MachineImageUploadDto(
            image: data['file'] as Uint8List,
            imageName: data['fileName'] as String,
          );

          MachineUploadDto machineUpload = MachineUploadDto(
              metaMachine: machineDbUploadDto, image: machineImageUploadDto);

          log.logInfo(
              'MachineDto created: ${machineUpload.metaMachine.machineName} : ${machineUpload.image.imageName}');

          await ref.read(createMachineDbProvider(machineUpload).future);
          Navigator.of(context).pop(true);
        } catch (e, stack) {
          log.logError('Failed to add machine: $e', stack);
          Navigator.of(context).pop(false);
        }
      },
      error: (err, stack) =>
          log.logError('Error during file pick: $err', stack),
      loading: () => log.logInfo('File picking: Loading'),
    );
  }
}
