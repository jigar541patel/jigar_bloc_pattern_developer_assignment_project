import 'package:isar/isar.dart';

import '../../screens/employeelistpage/model/employee.dart';



class EmployeeDao {
  final Isar isar;
  EmployeeDao(this.isar);

  Future<void> insert(Employee e) => isar.writeTxn(() => isar.employees.put(e));
  Future<void> delete(int id) => isar.writeTxn(() => isar.employees.delete(id));
  Future<List<Employee>> getAll() => isar.employees.where().findAll();
  Future<Employee?> getById(int id) async {
    return await isar.employees.get(id);
  }

  Future<void> update(Employee employee) async {
    await isar.writeTxn(() async {
      await isar.employees.put(employee);
    });
  }

}
