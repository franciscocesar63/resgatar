import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:resgatarv2/service/aluno_service.dart';

import '../controller/counter_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final counter = Counter();

  @override
  void initState() {
    super.initState();
    counter.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // AWSFile imagem = AWSFile.fromPath("assets/logo 156.jpg");
          // Image image = const Image.asset('assets/logo 156.jpg');
          // File file = await ImageUtil.assetToFile('/data/user/0/com.resgatarsousa.resgatarv2/cache/2bd351d7-440c-4797-a38a-bb07966bec44/IMG_20240111_010410.jpg');
          File file = File(
              '/data/user/0/com.resgatarsousa.resgatarv2/cache/2bd351d7-440c-4797-a38a-bb07966bec44/IMG_20240111_010410.jpg');
          Response enviarArquivo1 =
              await AlunoService.enviarArquivo1(file, "jpg");

          print("foi");

          // Navigator.pushNamed(context, '/cadastrar_aluno_view');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body() {
    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/logo 1090.png"),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/lista_alunos_matriculados_view');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Turminha Resgatar: ",
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/lista_alunos_matriculados_view');
                    },
                    icon: const Icon(Icons.child_care))
              ],
            ),
          ),
          const Text(
            "Let's Bora",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
