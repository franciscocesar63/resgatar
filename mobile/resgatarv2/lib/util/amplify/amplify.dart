import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../../amplifyconfiguration.dart';

class AmplifyUtil {

  static Future<void> configureAmplify() async {
    try {
      // final auth = AmplifyAuthCognito();
      final storage = AmplifyStorageS3();
      await Amplify.addPlugin(storage);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  static Future<void> getFileProperties() async {
    try {
      final result = await Amplify.Storage.getProperties(
        key: 'exampleamplify.txt',
      ).result;

      safePrint('File size: ${result.storageItem.size}');
    } on StorageException catch (e) {
      safePrint('Could not retrieve properties: ${e.message}');
      rethrow;
    }
  }

  static Future<void> uploadIOFile(File file) async {
    final awsFile = AWSFilePlatform.fromFile(file);
    print("vaiii");
    try {
      AuthUser user = await Amplify.Auth.getCurrentUser();
      final uploadResult = await Amplify.Storage.uploadFile(
        localFile: awsFile,
        key: 'upload/file.png',
      ).result;
      print('Uploaded file: ${uploadResult.uploadedItem.key}');
    } on StorageException catch (e) {
      print('Error uploading file: ${e.message}');
      rethrow;
    }
  }
}
