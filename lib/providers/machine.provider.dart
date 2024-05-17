import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/repository/machine.repository.dart';

import '../common/logging.dart';
import '../src/machine-grid/data/dto/new/machine_image_location_dto.dart';

final Logging log = Logging('machine.provider.dart');

final machineProvider = StateNotifierProvider<MachineNotifier,
    AsyncValue<List<MachineImageLocationDto>>>((ref) {
  return MachineNotifier(ref.read(machineRepositoryProvider));
});

final machineRepositoryProvider = Provider<MachineRepository>((ref) {
  return MachineRepository();
});

class MachineNotifier
    extends StateNotifier<AsyncValue<List<MachineImageLocationDto>>> {
  final MachineRepository repo;

  MachineNotifier(this.repo) : super(const AsyncValue.loading());

  Future<void> init() async {
    log.logInfo('Machine Provider');
    await repo.openBox();
    await loadMachineCardDto();
  }

  Future<void> loadMachineCardDto() async {
    state = const AsyncValue.loading();
    List<MachineImageLocationDto> machineCardDto = [];
    try {
      log.logInfo('Loading Machine Card Dto');
      machineCardDto = repo.getAllMachineCardDto();
      state = AsyncValue.data(machineCardDto);
      log.logInfo('Machine Card Dto loaded');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addMachineCardDto(MachineImageLocationDto machineCardDto) async {
    state = const AsyncValue.loading();
    repo.addMachineCardDto(machineCardDto);
    log.logDebug('Machine Card Dto added: $machineCardDto');
    state = AsyncValue.data(repo.getAllMachineCardDto());
  }

  Future<void> removeMachineCardDto(
      MachineImageLocationDto machineCardDto) async {
    repo.removeMachineCardDto(machineCardDto);
    await loadMachineCardDto();
  }

  Future<List<MachineImageLocationDto>> searchMachineCardDto(
      String fieldName, dynamic searchValue) async {
    List<MachineImageLocationDto> machineCardDto =
        await repo.searchMachineCardDto(fieldName, searchValue);
    log.logInfo('Machine Card Dto found: $machineCardDto');
    return machineCardDto;
  }
}
