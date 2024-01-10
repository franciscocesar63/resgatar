import 'package:flutter/material.dart';
import '../service/aluno_service.dart';
import '../model/aluno_model.dart';

class AlunoListView extends StatefulWidget {
  @override
  _AlunoListViewState createState() => _AlunoListViewState();
}

class _AlunoListViewState extends State<AlunoListView> {
  late Future<List<Aluno>> _alunosFuture;
  late List<Aluno> _alunos = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _alunosFuture = _fetchAlunos();
  }

  Future<List<Aluno>> _fetchAlunos() async {
    try {
      final AlunoService alunoService = AlunoService();
      return await alunoService.buscaAlunos();
    } catch (e) {
      throw Exception('Falha ao carregar alunos: $e');
    }
  }

  List<Aluno> _searchAlunos(String query) {
    query = query.toLowerCase();
    return _alunos.where((aluno) {
      final nome = aluno.nome.toLowerCase();
      return nome.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alunos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por nome',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _alunosFuture = _fetchAlunos();
                    });
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _alunos = _searchAlunos(value);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Aluno>>(
              future: _alunosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum aluno encontrado.'));
                } else {
                  _alunos = snapshot.data!;
                  return ListView.builder(
                    itemCount: _alunos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_alunos[index].nome),
                        // Mostrar mais detalhes ou ações para o aluno aqui, se necessário
                        // Exemplo: subtitle, onTap, etc.
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
