import 'package:flutter/material.dart';

import '../routes/routes.dart';
import 'util/color.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: Routes.routes,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(117, 187, 102, 1.0),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              iconTheme: IconThemeData(color: Colors.white)),
          primarySwatch: ColorUtil.getMaterialColor(
              const Color.fromRGBO(117, 187, 102, 1.0)),
          primaryColor: ColorUtil.getMaterialColor(
              const Color.fromRGBO(117, 187, 102, 1.0))),
      initialRoute: '/',
    );
  }
}
