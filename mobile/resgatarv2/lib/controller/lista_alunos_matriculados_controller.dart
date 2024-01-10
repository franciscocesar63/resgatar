import 'package:flutter/material.dart';
import '../service/aluno_service.dart';

import '../model/aluno_model.dart';

class ListaAlunosMatriculadosController extends ValueNotifier<List<Aluno>> {
  ListaAlunosMatriculadosController() : super([]);

  final alunoService = AlunoService();
  increment(Aluno a) {
    super.value.add(a);
  }

  decrement(Aluno a) {
    super.value.removeWhere((element) => element.idAluno == a.idAluno);
  }

  Future<List<Aluno>> getAlunos(){
    return alunoService.buscaAlunos();
  }
}
