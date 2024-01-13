import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/lista_alunos_matriculados_controller.dart';
import '../model/aluno_model.dart';

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
  TextEditingController _searchController = TextEditingController();
  List<Aluno> _alunos = [];
  List<Aluno> _alunosFiltrados = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _updateAlunosList();
    _searchController.addListener(_filterAlunos);
  }

  void _updateAlunosList() {
    widget.controller.getAlunos().then((alunos) {
      setState(() {
        _alunos = alunos;
        _alunosFiltrados = alunos;
      });
    });
  }

  void _filterAlunos() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _alunosFiltrados = _alunos.where((aluno) {
        return aluno.nome.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Pesquisar',
        border: InputBorder.none,
        // suffixIcon: IconButton(
        //   icon: Icon(Icons.clear),
        //   onPressed: () {
        //     _searchController.clear();
        //     _filterAlunos();
        //   },
        // ),
      ),
    );
  }

  Widget _body() {
    if (_alunosFiltrados.isEmpty) {
      return Container(
        width: double.infinity,
        color: Colors.black,
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Colors.white, size: 50),
              Text(
                "Não há alunos cadastrados...",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ]),
      );
    }

    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: _alunosFiltrados.length,
        itemBuilder: (context, index) {
          Aluno aluno = _alunosFiltrados[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(aluno.foto),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              child: aluno.foto.trim().isEmpty
                  ? Text(aluno.nome.substring(0, 1))
                  : const Text(""),
            ),
            title: Text(
              aluno.nome,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Idade: ${aluno.idade} -- Visitante: ${aluno.isVisitante ? "Sim" : "Não"}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField()
            : const Text(
                'Alunos',
                style: TextStyle(color: Colors.white),
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filterAlunos();
                }
              });
            },
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/cadastrar_aluno_view').then((value) {
          _updateAlunosList();
        });
      },
    );
  }
}
