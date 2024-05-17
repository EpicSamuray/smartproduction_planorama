import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/constants.dart';
import '../provider/file_picker_provider.dart';

class UploadImageButton extends ConsumerWidget {
  const UploadImageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onTap: () => ref.read(filePickerProvider.notifier).pickFile(),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload, size: 100),
                  Text('Upload Image', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
