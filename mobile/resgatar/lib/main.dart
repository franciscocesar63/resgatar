import 'package:flutter/material.dart';
import 'package:resgatar/routes/routes.dart';

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
        primarySwatch: Colors.green,
        // getMaterialColor(const Color.fromRGBO(117, 187, 102, 1.0)),
        primaryColor: Colors.green,
      ),
      // getMaterialColor(const Color.fromRGBO(117, 187, 102, 1.0))),
      initialRoute: '/',
    );
  }

// MaterialColor getMaterialColor(Color color) {
//   final int red = color.red;
//   final int green = color.green;
//   final int blue = color.blue;
//   final int alpha = color.alpha;
//
//   final Map<int, Color> shades = {
//     50: Color.fromARGB(alpha, red, green, blue),
//     100: Color.fromARGB(alpha, red, green, blue),
//     200: Color.fromARGB(alpha, red, green, blue),
//     300: Color.fromARGB(alpha, red, green, blue),
//     400: Color.fromARGB(alpha, red, green, blue),
//     500: Color.fromARGB(alpha, red, green, blue),
//     600: Color.fromARGB(alpha, red, green, blue),
//     700: Color.fromARGB(alpha, red, green, blue),
//     800: Color.fromARGB(alpha, red, green, blue),
//     900: Color.fromARGB(alpha, red, green, blue),
//   };
//
//   return MaterialColor(color.value, shades);
// }
}
