import 'package:flutter/material.dart';

import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/dataobat.dart';

class DetailPageGudang extends StatefulWidget {
  final Obat? obat;

  DetailPageGudang({this.obat});

  @override
  _DetailPageGudangState createState() => _DetailPageGudangState();
}

class _DetailPageGudangState extends State<DetailPageGudang> {
  DbObat db = DbObat();

  TextEditingController? NamaObat;
  TextEditingController? MerkObat;
  TextEditingController? JenisObat;
  TextEditingController? StockObat;
  TextEditingController? HargaObat;

  @override
  void initState() {
    NamaObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.NamaObat);

    MerkObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.MerkObat);

    JenisObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.JenisObat);

    StockObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.StockObat);

    HargaObat = TextEditingController(
        text: widget.obat == null ? '' : widget.obat!.HargaObat);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Detail Data Obat',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.medication,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Nama Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: NamaObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_library,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Merk Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: MerkObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.switch_camera,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Jenis Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: JenisObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Stock Obat :", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: StockObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 1,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Harga Obat :  Rp.", style: TextStyle(fontSize: 18)),
                  Flexible(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      enabled: false,
                      controller: HargaObat,
                      decoration: InputDecoration(
                          border: InputBorder.none),
                    ),
                  ),
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
        ],
      ),
    );
  }

  Future<void> upsertObat() async {
    if (widget.obat != null) {
      //update
      await db.updateObat(Obat.fromMap({
        'id': widget.obat!.id,
        'NamaObat': NamaObat!.text,
        'MerkObat': MerkObat!.text,
        'JenisObat': JenisObat!.text,
        'StockObat': StockObat!.text,
        'HargaObat': HargaObat!.text,
      }));
      Navigator.pop(context, 'back');
    }
  }
}
