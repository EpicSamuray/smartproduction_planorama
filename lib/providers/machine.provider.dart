

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/models/machine.card.dto.dart';
import 'package:smartproduction_planorama/repository/machine.repository.dart';

import '../common/logging.dart';

final Logging log = Logging('machine.provider.dart');

final machineProvider = StateNotifierProvider<MachineNotifier, AsyncValue<List<MachineCardDto>>>((ref) {
  return MachineNotifier(ref.read(machineRepositoryProvider));
});

final machineRepositoryProvider = Provider<MachineRepository>((ref) {
  return MachineRepository();
});


class MachineNotifier extends StateNotifier<AsyncValue<List<MachineCardDto>>> {
  final MachineRepository repo;

  MachineNotifier(this.repo) : super(AsyncValue.loading()) {
   init();
  }

  Future<void> init() async {
    await repo.openBox();
    await loadMachineCardDto();
  }

  Future<void> loadMachineCardDto() async {
    state = const AsyncValue.loading();
    try{
      log.logInfo('Loading Machine Card Dto');
      List<MachineCardDto> machineCardDto = repo.getAllMachineCardDto();
      state = AsyncValue.data(machineCardDto);
      log.logInfo('Machine Card Dto loaded');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addMachineCardDto(MachineCardDto machineCardDto) async{
    repo.addMachineCardDto(machineCardDto);
    await loadMachineCardDto();
  }

  Future<void> removeMachineCardDto(MachineCardDto machineCardDto) async{
    repo.removeMachineCardDto(machineCardDto);
    await loadMachineCardDto();
  }
}
