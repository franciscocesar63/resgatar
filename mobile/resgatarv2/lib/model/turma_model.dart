import 'dart:convert';

class Turma {
  int idTurma;
  String nome;
  String descricaoComplementar;

  Turma({
    required this.idTurma,
    required this.nome,
    required this.descricaoComplementar,
  });

  factory Turma.get() {
    return Turma(
      idTurma: 0,
      nome: '',
      descricaoComplementar: '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'IDTURMA': idTurma,
      'NOME': nome,
      'DESCRICAO_COMPLEMENTAR': descricaoComplementar,
    };
  }

  factory Turma.fromMap(Map<String, dynamic> map) {
    return Turma(
      idTurma: int.tryParse(map['IDTURMA']) as int,
      nome: map['NOME'] as String ?? '',
      descricaoComplementar: map['DESCRICAO_COMPLEMENTAR'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Turma.fromJson(String source) =>
      Turma.fromMap(json.decode(source) as Map<String, dynamic>);
}
