import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resgatarv2/model/turma_model.dart';

import '../config.dart';

class TurmaService {
  TurmaService();

  static String host = 'https://api.resgatarsousa.com.br';

  Future<List<Turma>> buscaTurmas() async {
    final response = await http.get(
      Uri.parse("$host/getTurmas.php"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      var x = jsonData.map((e) => Turma.fromMap(e)).toList();
      return x;
    } else {
      throw Exception('Falha ao carregar turmas');
    }
  }
}
