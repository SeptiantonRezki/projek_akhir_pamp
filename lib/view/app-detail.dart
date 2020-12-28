import 'package:flutter/material.dart';
import 'package:projek_akhir_pamp/modal/data-filkom.dart';

class EntryForm extends StatefulWidget {
  final DataFILKOM dataFILKOM;
  EntryForm(this.dataFILKOM);
  @override
  EntryFormState createState() => EntryFormState(this.dataFILKOM);
}

class EntryFormState extends State<EntryForm> {
  DataFILKOM dataFILKOM;
  EntryFormState(this.dataFILKOM);
  TextEditingController descriptionController = TextEditingController();
  TextEditingController creatorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController pubdateController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (dataFILKOM != null) {
      descriptionController.text = dataFILKOM.description;
      creatorController.text = dataFILKOM.creator;
      titleController.text = dataFILKOM.title;
      pubdateController.text = dataFILKOM.pubdate;
      linkController.text = dataFILKOM.link;
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: dataFILKOM == null
                ? Text('Tambah Pengumuman')
                : Text('Edit Pengumuman'),
            leading: Icon(Icons.keyboard_arrow_left),
            backgroundColor: Colors.orange,
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Judul',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: linkController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Link url',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: creatorController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Penulis',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: pubdateController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Tanggal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                // tombol button
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      // tombol simpan
                      Expanded(
                        child: RaisedButton(
                          color: Colors.orange,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (dataFILKOM == null) {
                              // tambah data
                              dataFILKOM = DataFILKOM(
                                  idNews: '',
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  creator: creatorController.text,
                                  pubdate: pubdateController.text,
                                  link: linkController.text);
                            } else {
                              // rubah data
                              dataFILKOM.title = titleController.text;
                              dataFILKOM.description =
                                  descriptionController.text;
                              dataFILKOM.creator = creatorController.text;
                              dataFILKOM.link = linkController.text;
                              dataFILKOM.pubdate = pubdateController.text;
                            }
                            // kembali ke layar sebelumnya dengan membawa objek contact
                            Navigator.pop(context, dataFILKOM);
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      // tombol batal
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Cancel',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
