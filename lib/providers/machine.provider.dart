

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:smartproduction_planorama/models/machine.card.dto.dart';
import 'package:smartproduction_planorama/repository/machine.repository.dart';

import '../service/machine.service.dart';

final machineProvider = StateNotifierProvider<MachineNotifier, List<MachineCardDto>>((ref) {
  return MachineNotifier(ref.read(machineRepositoryProvider));
});

final machineRepositoryProvider = Provider<MachineRepository>((ref) {
  return MachineRepository(ref.read(machineServiceProvider));
});

final machineServiceProvider = Provider<MachineService>((ref) => MachineService(Hive.box<MachineCardDto>('machineCardDto')));

class MachineNotifier extends StateNotifier<List<MachineCardDto>> {
  final MachineRepository repo;

  MachineNotifier(this.repo) : super([]) {
   loadMachineCardDto();
  }

  void loadMachineCardDto() {
    state = repo.getAllMachineCardDto();
  }

  void addMachineCardDto(MachineCardDto machineCardDto) {
    repo.addMachineCardDto(machineCardDto);
    loadMachineCardDto();
  }

  void removeMachineCardDto(MachineCardDto machineCardDto) {
    repo.removeMachineCardDto(machineCardDto);
    loadMachineCardDto();
  }
}
