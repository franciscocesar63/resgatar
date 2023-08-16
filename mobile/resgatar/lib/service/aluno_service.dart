import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/aluno_model.dart';

class AlunoService {
  AlunoService();

  Future<List<Aluno>> buscaAlunos() async {
    final response = await http.get(Uri.parse("https://api.resgatarsousa.com.br/getAlunos.php"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      var x = jsonData.map((e) => Aluno.fromMap(e)).toList();
      return x;
    } else {
      throw Exception('Falha ao carregar alunos');
    }
  }
}
