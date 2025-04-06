import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../screens/employeelistpage/model/employee.dart';

class IsarService {
  late final Future<Isar> db;

  IsarService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([EmployeeSchema], directory: dir.path);
  }
}
