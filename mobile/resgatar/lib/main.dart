import 'package:flutter/material.dart';
import 'package:resgatar/view/cadastrar_aluno_view.dart';
import 'package:resgatar/view/home_page.dart';
import 'package:resgatar/view/lista_alunos_matriculados_view.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const HomePage(title: 'Flutter Demo Home Page'),
        '/lista_alunos_matriculados_view': (context) => ListaAlunosMatriculadosView(),
        '/cadastrar_aluno_view': (context) => CadastrarAlunoView(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
    );
  }
}

