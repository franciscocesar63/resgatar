import 'package:flutter/material.dart';
import 'package:resgatar/model/aluno_model.dart';

import '../controller/lista_alunos_matriculados_controller.dart'; // Certifique-se de importar o modelo Aluno corretamente

class ListaAlunosMatriculadosView extends StatefulWidget {
  final ListaAlunosMatriculadosController controller =
      ListaAlunosMatriculadosController();

  ListaAlunosMatriculadosView();

  @override
  _ListaAlunosMatriculadosViewState createState() =>
      _ListaAlunosMatriculadosViewState();
}

class _ListaAlunosMatriculadosViewState
    extends State<ListaAlunosMatriculadosView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alunos'),
      ),
      body: FutureBuilder<List<Aluno>>(
        future: widget.controller.getAlunos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os alunos.'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Nenhum aluno encontrado.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Aluno aluno = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(aluno.foto),
                    child: Text(aluno.nome.substring(0, 1)),
                  ),
                  title: Text(aluno.nome),
                  subtitle: Text('Idade: ${aluno.idade} -- Visitante: ${aluno.isVisitante ? "Sim" : "Não"}'),

                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.controller.decrement(aluno);
                      widget.controller.notifyListeners();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
