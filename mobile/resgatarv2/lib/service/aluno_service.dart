import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/aluno_model.dart';

class AlunoService {
  AlunoService();

  static String host = 'https://api.resgatarsousa.com.br';
  static String token = '208e5ec4e9082c9f1495906f75fa2a9931f2f924';

  Future<List<Aluno>> buscaAlunos() async {
    final response = await http.get(
      Uri.parse("$host/getAlunos.php"),
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

  Future<void> enviarArquivo(File arquivo) async {
    final String apiUrl = '$host/uploadFoto.php';

    try {
      // Cria a requisição HTTP com o método POST
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Anexa o arquivo à requisição
      request.files.add(
        await http.MultipartFile.fromPath(
          'arquivo', // Nome do campo no formulário do seu servidor
          arquivo.path,
        ),
      );

      // Adiciona o cabeçalho de autorização
      request.headers['Authorization'] = 'Bearer $token';

      // Envia a requisição e aguarda a resposta
      final response = await request.send();

      // Verifica o código de status da resposta
      if (response.statusCode == 200) {
        // Leitura e decodificação da resposta JSON (se necessário)
        final dynamic jsonData =
            json.decode(await response.stream.bytesToString());
        print('Resposta do servidor: $jsonData');
      } else {
        // Trata erros
        print(
            'Erro no envio do arquivo. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      // Trata exceções
      print('Erro ao enviar o arquivo: $e');
    }
  }

  static Future<Response> enviarArquivo1(File arquivo, String extensao) async {
    final String apiUrl = '$host/uploadFoto.php';

    try {
      // Codifica o arquivo para bytes
      List<int> bytes = await arquivo.readAsBytes();

      // Cria o objeto JSON
      final Map<String, dynamic> jsonData = {
        'arquivo': base64Encode(bytes), // Codifica os bytes para base64
        'extensao': extensao,
      };

      // Converte o JSON para uma string
      final String jsonString = json.encode(jsonData);

      // Cria a requisição HTTP com o método POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );
      return response;
      // Verifica o código de status da resposta
      // if (response.statusCode == 200) {
      //   final dynamic jsonData = json.decode(response.body);
      //   print('Resposta do servidor: $jsonData');
      // } else {
      //   // Trata erros
      //   print('Erro no envio do arquivo. Código de status: ${response.statusCode}');
      // }
    } catch (e) {
      // Trata exceções
      print('Erro ao enviar o arquivo: $e');
      return Response('Erro ao enviar o arquivo: $e', 500);
    }
  }

  Future<bool> cadastraAluno(Aluno aluno) async {
    File file = File(aluno.foto);
    Response responseFoto = await AlunoService.enviarArquivo1(file, "jpg");
    if (responseFoto.statusCode != 200) {
      return false;
    }
    Map<String, dynamic> data = json.decode(responseFoto.body);
    aluno.foto = "$host/${data['filePath']}";

    //gera o json a ser enviado:
    String jsonString = aluno.toJson();

    // Cria a requisição HTTP com o método POST
    final String apiUrl = '$host/insertAluno.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonString,
    );

    return response.statusCode == 200;
  }
}
