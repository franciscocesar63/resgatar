import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resgatarv2/service/aluno_service.dart';

import '../model/aluno_model.dart';

class CadastrarAlunoView extends StatefulWidget {
  @override
  _CadastrarAlunoViewState createState() => _CadastrarAlunoViewState();
}

class _CadastrarAlunoViewState extends State<CadastrarAlunoView> {
  final _formKey = GlobalKey<FormState>();
  Aluno _aluno = Aluno.get();
  AlunoService _service = AlunoService();
  XFile? _imageFile;
  File _imageTelas = File("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                GestureDetector(
                  onTap: _captureImage,
                  child: Image(
                    image: _imageAberta(),
                    height: 320,
                  ),
                  // child: Image.asset(
                  //     _imageFile == null
                  //         ? 'assets/logo 256.jpg'
                  //         : _imageFile!.path,
                  //     width: 160),
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
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

                  title: Text('É visitante?', style: TextStyle(color: Colors.white),),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_imageFile);

                      bool res = await _service.cadastraAluno(_aluno);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(res ? "Sucesso!" : "Atenção!"),
                            content: Text(res
                                ? "Aluno cadastrado!"
                                : "Erro ao cadastrar o Aluno!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
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

  Future<void> _captureImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = image;
        _aluno.foto = _imageFile!.path;
      });
    }
  }

  _imageAberta() {
    if (_imageFile != null) {
      return FileImage(File(_imageFile!.path));
    } else {
      return const AssetImage(
          'assets/logo 256.jpg');
    }
  }
}
