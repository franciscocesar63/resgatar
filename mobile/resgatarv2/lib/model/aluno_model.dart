import 'dart:convert';

class Aluno {
  int idAluno;
  int idTurma;
  String nome;
  DateTime dataNascimento;
  int idade;
  String escolaridade;
  String nomeEscola;
  String horarioEstuda;
  String nomeResponsavel;
  String telefoneResponsavel;
  String instagramResponsavel;
  String foto;
  String rua;
  String bairro;
  String cep;
  String cidade;
  String estado;
  bool isVisitante;
  String pais;
  DateTime dataHora;

  Aluno({
    required this.idAluno,
    required this.idTurma,
    required this.nome,
    required this.dataNascimento,
    required this.idade,
    required this.escolaridade,
    required this.nomeEscola,
    required this.horarioEstuda,
    required this.nomeResponsavel,
    required this.telefoneResponsavel,
    required this.instagramResponsavel,
    required this.foto,
    required this.rua,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.estado,
    required this.isVisitante,
    required this.pais,
    required this.dataHora,
  });
  factory Aluno.get() {
    return Aluno(
      idAluno: 0,
      idTurma: -1,
      nome: '',
      dataNascimento: DateTime(1970),
      idade: 0,
      escolaridade: '',
      nomeEscola: '',
      horarioEstuda: '',
      nomeResponsavel: '',
      telefoneResponsavel: '',
      instagramResponsavel: '',
      foto: '',
      rua: '',
      bairro: '',
      cep: '',
      cidade: '',
      estado: '',
      isVisitante: false,
      pais: '',
      dataHora: DateTime(1970),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'IDALUNO': idAluno,
      'IDTURMA': idTurma,
      'NOME': nome,
      'DATANASCIMENTO': dataNascimento.millisecondsSinceEpoch,
      'IDADE': idade,
      'ESCOLARIDADE': escolaridade,
      'NOMEESCOLA': nomeEscola,
      'HORARIOESTUDA': horarioEstuda,
      'NOMERESPONSAVEL': nomeResponsavel,
      'TELEFONERESPONSAVEL': telefoneResponsavel,
      'INSTAGRAMRESPONSAVEL': instagramResponsavel,
      'FOTO': foto,
      'RUA': rua,
      'BAIRRO': bairro,
      'CEP': cep,
      'CIDADE': cidade,
      'ESTADO': estado,
      'ISVISITANTE': isVisitante,
      'PAIS': pais,
      'DATAHORA': dataHora.millisecondsSinceEpoch,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      idAluno: int.tryParse(map['IDALUNO']) as int,
      idTurma: int.tryParse(map['IDTURMA']) as int,
      nome: map['NOME'] as String,
      dataNascimento: DateTime.parse(map['DATANASCIMENTO']).toLocal(),
      idade: int.tryParse(map['IDADE']) as int,
      escolaridade: map['ESCOLARIDADE'] as String,
      nomeEscola: map['NOMEESCOLA'] as String,
      horarioEstuda: map['HORARIOESTUDA'] as String,
      nomeResponsavel: map['NOMERESPONSAVEL'] as String,
      telefoneResponsavel: map['TELEFONERESPONSAVEL'] as String,
      instagramResponsavel: map['INSTAGRAMRESPONSAVEL'] == null
          ? ""
          : map['INSTAGRAMRESPONSAVEL'] as String,
      foto: map['FOTO'] as String,
      rua: map['RUA'] as String,
      bairro: map['BAIRRO'] as String,
      cep: map['CEP'] as String,
      cidade: map['CIDADE'] as String,
      estado: map['ESTADO'] as String,
      isVisitante: int.tryParse(map['ISVISITANTE']) == 1,
      pais: map['PAIS'] as String,
      dataHora: DateTime.parse(map['DATAHORA']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Aluno.fromJson(String source) =>
      Aluno.fromMap(json.decode(source) as Map<String, dynamic>);
}
