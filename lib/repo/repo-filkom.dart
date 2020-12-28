import 'package:projek_akhir_pamp/config/api.dart';
import 'package:projek_akhir_pamp/modal/data-filkom.dart';

class FilkomRepository {
  ServiceAPI _helper = ServiceAPI();

  Future<List<DataFILKOM>> fetchDataList() async {
    List<dynamic> response = await _helper.getData();
    List<DataFILKOM> data = new List<DataFILKOM>();

    data = response.map((dynamic item) {
      return DataFILKOM.fromJson(item);
    }).toList();
    return data;
  }

  Future<DataFILKOM> postData(DataFILKOM dataInput) async {
    dynamic response = await _helper.postData(dataInput);
    DataFILKOM data = new DataFILKOM();
    data = DataFILKOM.fromJson(response);
    return data;
  }

  Future<DataFILKOM> updateData(DataFILKOM dataInput, String id) async {
    dynamic response = await _helper.updateData(dataInput, id);
    DataFILKOM data = new DataFILKOM();
    data = DataFILKOM.fromJson(response);
    return data;
  }

  Future deleteData(String id) async {
    dynamic response = await _helper.deleteData(id);
    return response;
  }
}

// Future<void> main() async {
//   FilkomRepository data = new FilkomRepository();
//   List<DataFILKOM> dataCetak = await data.fetchMovieList();
//   dataCetak.forEach((element) {
//     print(element.creator);
//   });
//   DataFILKOM dataInput = DataFILKOM(
//       title: 'title update',
//       description: 'description update',
//       creator: 'creator update',
//       link: 'link update',
//       pubdate: 'pubdate update');
//   DataFILKOM dataUpdate = await data.updateData(dataInput, '202007');
//   DataFILKOM dataInsert = await data.postData(dataInput);
//   var dataDelete = await data.deleteData('202012');
//   print(dataInsert.title);
//   print(dataDelete['status']);
// }
