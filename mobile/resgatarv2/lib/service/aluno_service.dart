import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/aluno_model.dart';

class AlunoService {
  AlunoService();

  Future<List<Aluno>> buscaAlunos() async {
    final String token =
        '208e5ec4e9082c9f1495906f75fa2a9931f2f924';

    final response = await http.get(
      Uri.parse("https://api.resgatarsousa.com.br/getAlunos.php"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      var x = jsonData.map((e) => Aluno.fromMap(e)).toList();
      return x;
    } else {
      throw Exception('Falha ao carregar alunos');
    }
  }
}
