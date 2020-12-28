import 'dart:async';
import 'package:projek_akhir_pamp/config/api-response.dart';
import 'package:projek_akhir_pamp/modal/data-filkom.dart';
import 'package:projek_akhir_pamp/repo/repo-filkom.dart';

class DataBloc {
  // ambil fetct saja
  FilkomRepository _filkomRepository;

  StreamController _filkomListController;

  StreamSink<ApiResponse<List<DataFILKOM>>> get dataListSink {
    return _filkomListController.sink;
  }

  Stream<ApiResponse<List<DataFILKOM>>> get dataListStream {
    return _filkomListController.stream;
  }

  DataBloc() {
    _filkomListController = StreamController<ApiResponse<List<DataFILKOM>>>();
    _filkomRepository = FilkomRepository();
    fetchDataList();
  }

  fetchDataList() async {
    dataListSink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      List<DataFILKOM> datas = await _filkomRepository.fetchDataList();
      dataListSink.add(ApiResponse.completed(datas));
    } catch (e) {
      dataListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _filkomListController?.close();
  }
}
