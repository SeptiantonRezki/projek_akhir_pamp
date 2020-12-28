import 'package:flutter/material.dart';

class AppGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: ListView(
          children: [
            Wrap(
              children: [
                CardProfile('Septianton Rezki Raahmatulloh', '175150600111011',
                    'anton'),
                CardProfile('M. Afton Ilman Huda', '175150600111026', 'afton'),
                CardProfile('Nando Krisna Carera', '175150601111043', 'nando'),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  String nama;
  String nim;
  String namaGambar;
  CardProfile(this.nama, this.nim, this.namaGambar);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width / 1,
      child: Card(
        elevation: 2.5,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            height: 200,
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage('resource/$namaGambar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$nama",
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "NIM: $nim",
                          style: TextStyle(letterSpacing: 1.5, height: 1.5),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Container(
                        //   child: Align(
                        //     alignment: Alignment.centerRight,
                        //     child: RaisedButton(
                        //       onPressed: () {},
                        //       child: Text("button"),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
