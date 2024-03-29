import 'package:flutter/material.dart';
import 'package:resgatar/controller/counter_controller.dart';

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
        onPressed: () {
          Navigator.pushNamed(context, '/cadastrar_aluno_view');
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
