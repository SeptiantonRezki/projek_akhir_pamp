import 'package:flutter/material.dart';
import 'package:projek_akhir_pamp/bloc/data-bloc.dart';
import 'package:projek_akhir_pamp/config/api-response.dart';
import 'package:projek_akhir_pamp/modal/data-filkom.dart';
import 'package:projek_akhir_pamp/repo/repo-filkom.dart';
import 'package:projek_akhir_pamp/view/app-detail.dart';
import 'package:projek_akhir_pamp/view/app-group.dart';

class AppUpdate extends StatefulWidget {
  @override
  _AppUpdateState createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {
  DataBloc _bloc;
  FilkomRepository data = FilkomRepository();

  @override
  void initState() {
    super.initState();
    _bloc = DataBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

// navigation
  Future<DataFILKOM> navigateToDetail(
      BuildContext context, DataFILKOM dataFILKOM) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(dataFILKOM);
    }));
    return result;
  }

  // tambah data mahasiswa
  void addBook(DataFILKOM dataInput) async {
    await data.postData(dataInput);
  }

  // update data terbaru dari database
  void editBook(DataFILKOM dataInput, String id) async {
    await data.updateData(dataInput, id);
  }

// menghapus data mahssiwa
  void deleteBook(String id) async {
    await data.deleteData(id);
  }

  ListView createListView(List<DataFILKOM> dataList) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      EdgeInsets.only(bottom: 10, top: 20, right: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${dataList[index].title}',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'penulis: ${dataList[index].creator}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${dataList[index].description}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(right: 10),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () async {
                                // var dataDetail = await navigateToDetail(
                                //     context, dataList[index]);
                                // if (dataDetail != null) {
                                deleteBook('${dataList[index].idNews}');
                                setState(() {
                                  _bloc.fetchDataList();
                                });
                                // }
                              },
                              child: Text(
                                'HAPUS',
                                style: TextStyle(
                                  color: Colors.orange[700],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              color: Colors.orange[800],
                              onPressed: () async {
                                var dataDetail = await navigateToDetail(
                                    context, dataList[index]);
                                if (dataDetail != null) {
                                  editBook(
                                      dataDetail, '${dataList[index].idNews}');
                                  setState(() {
                                    _bloc.fetchDataList();
                                  });
                                }
                              },
                              child: Text(
                                'DETAIL',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.27,
              padding: EdgeInsets.only(right: 20, left: 20, top: 10),
              child: RefreshIndicator(
                onRefresh: () => _bloc.fetchDataList(),
                child: StreamBuilder<ApiResponse<List<DataFILKOM>>>(
                  stream: _bloc.dataListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );
                          break;
                        case Status.COMPLETED:
                          return createListView(snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Error(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () => _bloc.fetchDataList(),
                          );
                          break;
                      }
                    }
                    return Container();
                  },
                ),
                // child: createListView(),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () async {
                var dataDetail = await navigateToDetail(context, null);
                if (dataDetail != null) {
                  addBook(dataDetail);
                  setState(() {
                    _bloc.fetchDataList();
                  });
                }
              },
              child: Icon(
                Icons.add_box,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 70,
        color: Colors.orange[700],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //   return AppUpdate();
                // }));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                width: 70,
                height: 55,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AppGroup();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                width: 70,
                height: 55,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.group),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Kelompok',
                      style:
                          TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
