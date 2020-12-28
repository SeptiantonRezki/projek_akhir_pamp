import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:projek_akhir_pamp/modal/data-filkom.dart';
import 'package:projek_akhir_pamp/utils/app-exception.dart';

//  api get-post-put-delete
class ServiceAPI {
  final String _baseUrl = "http://192.168.43.137/demo-api/index.php/api/news";
  // final String _baseUrl = "http://127.0.0.1/demo-api/index.php/api/news";

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 502:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> getData() async {
    var responseJson;
    try {
      final response = await get(_baseUrl);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postData(DataFILKOM dataInput) async {
    var responseJson;
    try {
      final response = await post(
        _baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(DataFILKOM.toJson(dataInput)),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> updateData(DataFILKOM dataInput, String id) async {
    var responseJson;
    try {
      final response = await put(
        _baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(DataFILKOM.toJsonWithId(dataInput, id)),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteData(String id) async {
    var responseJson;
    try {
      final response = await delete(
        '$_baseUrl/$id',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
// Future<void> main() async {
// List<DataFILKOM> data = await ServiceAPI.getData();
// data.forEach((e) {
//   print(e.description);
// });
// DataFILKOM dataInput = DataFILKOM(
//     title: 'title',
//     description: 'descriptioan',
//     creator: 'creator',
//     link: 'link',
//     pubdate: 'pubdate');
// print(await ServiceAPI.postData(dataInput));
// }
