import 'package:flutter_test/flutter_test.dart';
import 'package:resgatar/model/aluno_model.dart';
import 'package:resgatar/service/aluno_service.dart';

void main() {
  group('AlunoService', () {
    test('buscaAlunos retorna uma lista de alunos', () async {
      final service = AlunoService();
      final alunos = await service.buscaAlunos();

      // Verifica se a lista de alunos não é nula
      expect(alunos, isNotNull);

      // Verifica se a lista de alunos contém pelo menos um aluno
      expect(alunos.length, greaterThan(0));

      // Verifica se todos os alunos possuem um nome não nulo
      for (final aluno in alunos) {
        expect(aluno.nome, isNotNull);
      }
    });

    test('buscaAlunos retorna uma lista vazia quando não há alunos', () async {
      // Simula um serviço que não possui alunos
      final service = AlunoServiceMockSemAlunos();

      final alunos = await service.buscaAlunos();

      // Verifica se a lista de alunos é vazia
      expect(alunos, isEmpty);
    });
  });
}

// Classe mock para simular um serviço sem alunos
class AlunoServiceMockSemAlunos extends AlunoService {
  @override
  Future<List<Aluno>> buscaAlunos() async {
    return [];
  }
}
