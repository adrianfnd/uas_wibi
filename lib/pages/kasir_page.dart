import 'package:flutter/material.dart';

import 'package:uas_wibi/database/db_obat.dart';
import 'package:uas_wibi/model/dataobat.dart';
import 'package:uas_wibi/pages/gudang_page.dart';
import 'package:uas_wibi/pages/widget/detail_page.dart';


class KasirMenuPage extends StatefulWidget {
  const KasirMenuPage({Key? key}) : super(key: key);

  @override
  _KasirMenuPageState createState() => _KasirMenuPageState();
}

class _KasirMenuPageState extends State<KasirMenuPage> {
  int _selectedScreenIndex = 1;
  final List _screens = [
    {"screen": const GudangPage(), "title": "Screen A Title"},
    {"screen": const KasirPage(), "title": "Screen B Title"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: "Gudang"),
          BottomNavigationBarItem(icon: Icon(Icons.calculate_sharp), label: "Kasir")
        ],
      ),
    );
  }
}

class KasirPage extends StatefulWidget {
  const KasirPage({Key? key}) : super(key: key);

  @override
  KasirPageState createState() => KasirPageState();
}

class KasirPageState extends State<KasirPage> {
  List<Obat> listObat = [];
  DbObat db = DbObat();

  @override
  void initState() {
    _getAllObat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'Kasir',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView.builder(
          itemCount: listObat.length,
          itemBuilder: (context, index) {
            Obat obat = listObat[index];
            return Container(
              child: Card(
                child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        leading: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:<Widget>[ Icon(
                              Icons.medical_services_outlined,
                              size: 50,
                            )
                            ]
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text("Nama Obat: ${obat.NamaObat}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text("Merk Obat: ${obat.MerkObat}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text("Harga : Rp.${obat.HargaObat}"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _openFormLook(obat);
                    }
                ),
              ),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 50.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  //mengambil semua data Obat
  Future<void> _getAllObat() async {
    var list = await db.getAllObat();
    setState(() {
      listObat.clear();
      list!.forEach((obat) {
        listObat.add(Obat.fromMap(obat));
      });
    });
  }

  Future<void> _deleteObat(Obat obat, int position) async {
    await db.deleteObat(obat.id!);
    setState(() {
      listObat.removeAt(position);
    });
  }

  Future<void> _openFormLook(Obat obat) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(obat: obat)));
    if (result == 'back') {
      await _getAllObat();
    }
  }
}
