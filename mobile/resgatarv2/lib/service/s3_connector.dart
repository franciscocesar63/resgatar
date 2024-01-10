import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class S3Connector {
  static Future<void> enviarFotoS3(AWSFile imagem) async {
    final key = '${imagem.name}-${imagem.bytes}}}'; // Nome do arquivo no S3
    try {
      S3UploadFileResult result = (await Amplify.Storage.uploadFile(
        localFile: imagem,
        key: key,
      )) as S3UploadFileResult;
      print('Foto enviada com sucesso para o S3: ${result.uploadedItem}');
      print('Foto enviada com sucesso para o S3: ${result.uploadedItem.key}');
    } catch (e) {
      print('Erro ao enviar foto para o S3: $e');
    }
  }
}
