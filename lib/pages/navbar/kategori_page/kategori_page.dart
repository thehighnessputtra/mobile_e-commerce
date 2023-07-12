import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/kategori_page/kategori_card.dart';
import 'package:test_aplikasi/utils/constant.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('kategori').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListKategoriPage(
                listProduk: snapshot.data!.docs,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ListKategoriPage extends StatefulWidget {
  final List<DocumentSnapshot> listProduk;
  int itemCount;
  bool setCount;
  ListKategoriPage(
      {super.key,
      required this.listProduk,
      this.itemCount = 1,
      this.setCount = false});

  @override
  State<ListKategoriPage> createState() => _ListKategoriPageState();
}

class _ListKategoriPageState extends State<ListKategoriPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount:
            widget.setCount ? widget.itemCount : widget.listProduk.length,
        itemBuilder: (context, index) {
          final itemsList = widget.listProduk[index];
          String storageKategori = itemsList['kategori'];
          List storageListGame = itemsList['listGame'];

          return KategoriCard(
            listGame: storageListGame,
            namaKategori: storageKategori,
          );
        });
  }
}
