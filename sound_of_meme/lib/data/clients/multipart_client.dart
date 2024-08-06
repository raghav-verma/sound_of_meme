import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../constants/constants.dart';
import '../models/models.dart';

//Note:
//We have to make a manual client as Retrofit is having issues generating toJson for MultipartFile.
//Without proper MultipartFile encoding backend would be having issues recognising the audio uploaded.
class MultipartClient {
  final Dio _dio;

  MultipartClient(this._dio);

  Future<SongResponseModel?> cloneSong(
    File file,
    String prompt,
    String lyrics,
  ) async {
    final fileName = file.path.split('/').last;

    MultipartFile multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: MediaType(
        RemoteDataBaseConstants.audioMediaType,
        RemoteDataBaseConstants.audioMediaSubType,
      ),
    );

    FormData formData = FormData.fromMap({
      RemoteDataBaseConstants.file: multipartFile,
      RemoteDataBaseConstants.prompt: prompt,
      RemoteDataBaseConstants.lyrics: lyrics,
    });

    final response = await _dio.post(
      RemoteDataBaseConstants.cloneSongEndPoint,
      data: formData,
    );

    if (response.statusCode == 200) {
      return SongResponseModel.fromJson(response.data);
    }

    return null;
  }
}
