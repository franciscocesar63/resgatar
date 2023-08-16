import 'package:flutter/material.dart';

import '../model/aluno_model.dart';

class CadastrarAlunoView extends StatefulWidget {
  @override
  _CadastrarAlunoViewState createState() => _CadastrarAlunoViewState();
}

class _CadastrarAlunoViewState extends State<CadastrarAlunoView> {
  final _formKey = GlobalKey<FormState>();
  Aluno _aluno = Aluno.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Aluno'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => _aluno.nome = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Data de Nascimento'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      _aluno.dataNascimento = DateTime.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Idade'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => _aluno.idade = int.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Escolaridade'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => _aluno.escolaridade = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome da Escola'),
                  onSaved: (value) => _aluno.nomeEscola = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Horário de Estudo'),
                  onSaved: (value) => _aluno.horarioEstuda = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome do Responsável'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => _aluno.nomeResponsavel = value!,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Telefone do Responsável'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => _aluno.telefoneResponsavel = value!,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Instagram do Responsável'),
                  onSaved: (value) => _aluno.instagramResponsavel = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Foto'),
                  onSaved: (value) => _aluno.foto = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Rua'),
                  onSaved: (value) => _aluno.rua = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Bairro'),
                  onSaved: (value) => _aluno.bairro = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CEP'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _aluno.cep = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cidade'),
                  onSaved: (value) => _aluno.cidade = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Estado'),
                  onSaved: (value) => _aluno.estado = value!,
                ),
                CheckboxListTile(
                  title: Text('É visitante?'),
                  value: _aluno.isVisitante,
                  onChanged: (value) {
                    setState(() {
                      _aluno.isVisitante = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'País'),
                  onSaved: (value) => _aluno.pais = value!,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Chame a função para salvar o aluno no banco de dados ou onde for necessário
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
