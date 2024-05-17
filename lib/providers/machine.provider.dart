import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/repository/machine.repository.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_image_dto.dart';

import '../common/logging.dart';

final Logging log = Logging('machine.provider.dart');

final machineProvider =
    StateNotifierProvider<MachineNotifier, AsyncValue<List<MachineImageDto>>>(
        (ref) {
  return MachineNotifier(ref.read(machineRepositoryProvider));
});

final machineRepositoryProvider = Provider<MachineRepository>((ref) {
  return MachineRepository();
});

class MachineNotifier extends StateNotifier<AsyncValue<List<MachineImageDto>>> {
  final MachineRepository repo;

  MachineNotifier(this.repo) : super(const AsyncValue.loading());

  Future<void> init() async {
    log.logInfo('Machine Provider');
    await repo.openBox();
    await loadMachineCardDto();
  }

  Future<void> loadMachineCardDto() async {
    state = const AsyncValue.loading();
    List<MachineImageDto> machineCardDto = [];
    try {
      log.logInfo('Loading Machine Card Dto');
      machineCardDto = repo.getAllMachineCardDto();
      state = AsyncValue.data(machineCardDto);
      log.logInfo('Machine Card Dto loaded');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addMachineCardDto(MachineImageDto machineCardDto) async {
    state = const AsyncValue.loading();
    repo.addMachineCardDto(machineCardDto);
    log.logDebug('Machine Card Dto added: $machineCardDto');
    state = AsyncValue.data(repo.getAllMachineCardDto());
  }

  Future<void> removeMachineCardDto(MachineImageDto machineCardDto) async {
    repo.removeMachineCardDto(machineCardDto);
    await loadMachineCardDto();
  }

  Future<List<MachineImageDto>> searchMachineCardDto(
      String fieldName, dynamic searchValue) async {
    List<MachineImageDto> machineCardDto =
        await repo.searchMachineCardDto(fieldName, searchValue);
    log.logInfo('Machine Card Dto found: $machineCardDto');
    return machineCardDto;
  }
}
