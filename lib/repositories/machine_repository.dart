abstract class MachineRepository {
  Future<List<Machine>> getAllMachines();
  Future<Machine> getMachineById(String id);
  Future<void> addMachine(Machine machine);
  Future<void> updateMachine(Machine machine);
  Future<void> deleteMachine(String id);
}