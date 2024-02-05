import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resgatarv2/model/turma_model.dart';
import 'package:resgatarv2/service/aluno_service.dart';
import 'package:resgatarv2/service/turma_service.dart';

import '../model/aluno_model.dart';

class CadastrarAlunoView extends StatefulWidget {
  @override
  _CadastrarAlunoViewState createState() => _CadastrarAlunoViewState();
}

class _CadastrarAlunoViewState extends State<CadastrarAlunoView> {
  final _formKey = GlobalKey<FormState>();
  Aluno _aluno = Aluno.get();
  AlunoService _service = AlunoService();
  TurmaService _turmaService = TurmaService();
  List<Turma> _turmasList = [];
  XFile? _imageFile;
  File _imageTelas = File("");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _turmaService.buscaTurmas().then((list) {
      setState(() {
        _turmasList = list;
      });
    });
  }

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
              children: formulario(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> formulario(BuildContext context) {
    return [
      GestureDetector(
        onTap: _captureImage,
        child: Image(
          image: _imageAberta(),
          height: 320,
        ),
      ),
      //Nome
      _textFormField(
          (value) => _aluno.nome = value!, 'Nome', TextInputType.name, null),

      _textFormField((value) => _aluno.dataNascimento = DateTime.parse(value!),
          'Data de Nascimento', TextInputType.datetime, <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ]),

      _textFormField((value) => _aluno.idade = int.parse(value!), 'Idade',
          TextInputType.number, <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ]),

      _textFormField(
          (value) => _aluno.escolaridade = value!, 'Escolaridade', null, null),

      _textFormField(
          (value) => _aluno.nomeEscola = value!, 'Nome da Escola', null, null),

      buildDropHorarioEstuda(),

      buildDropDownTurma(),
      // buildDropdownButtonFormField(buildTurmaDropDownMenuItem(), 'Turma'),

      _textFormField((value) => _aluno.nomeResponsavel = value!,
          'Nome do Responsável', null, null),

      _textFormField((value) => _aluno.telefoneResponsavel = value!,
          'Telefone do Responsável', TextInputType.phone, null),

      _textFormField((value) => _aluno.instagramResponsavel = value!,
          'Instagram do Responsável', null, null),

      _textFormField((value) => _aluno.rua = value!, 'Rua', null, null),

      _textFormField((value) => _aluno.bairro = value!, 'Bairro', null, null),
      _textFormField(
          (value) => _aluno.cep = value!, 'CEP', TextInputType.number, null),

      _textFormField((value) => _aluno.cidade = value!, 'Cidade', null, null),

      _textFormField((value) => _aluno.estado = value!, 'Estado', null, null),

      _textFormField((value) => _aluno.pais = value!, 'País', null, null),

      CheckboxListTile(
        title: const Text(
          'É visitante?',
          style: TextStyle(color: Colors.white),
        ),
        value: _aluno.isVisitante,
        onChanged: (value) {
          setState(() {
            _aluno.isVisitante = value!;
          });
        },
      ),

      botaoCadastrar(context),
    ];
  }

  ElevatedButton botaoCadastrar(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          String erro = "";
          if (_imageFile == null) {
            erro = 'É obrigatório a captura da foto!';
          }

          bool res = await _service.cadastraAluno(_aluno);

          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(res ? "Sucesso!" : "Atenção!"),
                content: Text(res
                    ? "Aluno cadastrado!"
                    : "Erro ao cadastrar o Aluno! $erro"),
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

          if (res) {
            Navigator.pop(context);
          }
        }
      },
      child: const Text('Cadastrar'),
    );
  }

  Padding buildDropDownTurma() {
    List<DropdownMenuItem<int>> list = buildTurmaDropDownMenuItem();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownButtonFormField<int>(
        dropdownColor: Colors.black,
        decoration: const InputDecoration(
          labelText: 'Turma',
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        value: _aluno.idTurma ?? -1,
        style: const TextStyle(color: Colors.white),
        items: list,
        onChanged: (value) {
          setState(() {
            _aluno.idTurma = value as int;
          });
        },
        validator: (value) {
          if (value == null || value == -1) {
            return 'Selecione uma Turma';
          }
          return null;
        },
        onSaved: (value) {
          _aluno.idTurma = value as int;
        },
      ),
    );
  }

  Padding buildDropHorarioEstuda() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.black,
        decoration: const InputDecoration(
          labelText: 'Horário de Estudo',
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        value: _aluno.horarioEstuda ?? "",
        style: const TextStyle(color: Colors.white),
        items: const [
          DropdownMenuItem(
            value: "",
            child: Text('Selecione um horário'),
          ),
          DropdownMenuItem(
            value: 'Manhã',
            child: Text('Manhã'),
          ),
          DropdownMenuItem(
            value: 'Tarde',
            child: Text('Tarde'),
          ),
          DropdownMenuItem(
            value: 'Noite',
            child: Text('Noite'),
          ),
        ],
        onChanged: (value) {
          // Atualiza o estado quando a opção do dropdown é alterada
          setState(() {
            _aluno.horarioEstuda = value as String;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Selecione um horário de estudo';
          }
          return null;
        },
        onSaved: (value) {
          _aluno.horarioEstuda = value!;
        },
      ),
    );
  }

  List<DropdownMenuItem<int>> buildTurmaDropDownMenuItem() {
    var item1 = const DropdownMenuItem<int>(
      value: -1,
      child: Text('Selecione uma turma'),
    );
    List<DropdownMenuItem<int>> xx = [];

    xx.add(item1);

    List<DropdownMenuItem<int>> list = _turmasList.map((item) {
      return DropdownMenuItem<int>(
        value: item.idTurma!,
        child: Text(item.nome),
      );
    }).toList();
    //
    // list.insert(0, item1);
    xx.addAll(list);
    return xx;
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
      return const AssetImage('assets/logo 256.jpg');
    }
  }

  Widget _textFormField(onSaved, labelText, keyboardType, inputFormatters) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context)
                    .primaryColor), // Border color when selected
          ),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
