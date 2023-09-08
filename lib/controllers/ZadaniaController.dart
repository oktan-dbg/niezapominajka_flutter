import 'package:get/get.dart';
import 'package:niezapominajka_flutter/db/ZadaniaHelper.dart';
import 'package:niezapominajka_flutter/models/Zadania.dart';


class ZadaniaController extends GetxController{ 
  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Zadania>[].obs;

  Future<int> addTask({Zadania? zadania}) async{
    return await ZadaniaHelper.insert(zadania);
  }

  void getTasks() async {
    List<Map<String, dynamic>> zadania = await ZadaniaHelper.query();
    taskList.assignAll(zadania.map((data) => new Zadania.fromJson(data)).toList());
  }

  void delete(Zadania zadania){
    ZadaniaHelper.delete(zadania);
    getTasks();
  }

  void markTaskCompleted(int id)async{
    await ZadaniaHelper.update(id);
    getTasks();
  }
} 