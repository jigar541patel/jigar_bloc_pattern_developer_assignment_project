import '../../../data/local/employee_dao.dart';
import '../model/employee.dart';

class EmployeeRepository {
  final EmployeeDao dao;
  EmployeeRepository(this.dao);

  Future<List<Employee>> fetchAll() => dao.getAll();
  Future<void> add(Employee e) => dao.insert(e);
  Future<void> delete(int id) => dao.delete(id);

  Future<Employee?> getById(int id) => dao.getById(id);  // new
  Future<void> update(Employee e) => dao.update(e);      // new
}
