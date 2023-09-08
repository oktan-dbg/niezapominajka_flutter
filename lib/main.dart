import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:niezapominajka_flutter/db/ZadaniaHelper.dart';
import 'package:niezapominajka_flutter/pages/mainPage.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZadaniaHelper.initDb();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home: MainPage()
    );
  }
}