import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_card.dart';

class DetailKategoriPage extends StatefulWidget {
  DetailKategoriPage(
      {super.key, required this.namaKategori, required this.listGame});
  String namaKategori = '...';
  List listGame = [];

  @override
  State<DetailKategoriPage> createState() => _DetailKategoriPageState();
}

class _DetailKategoriPageState extends State<DetailKategoriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.namaKategori),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('produkList')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final dataProduk = snapshot.data!.docs[index];

                      return Column(
                          children: widget.listGame.map((e) {
                        if (e == dataProduk.get("nama")) {
                          return ProdukCard(
                            nama: dataProduk.get("nama"),
                            deskripsi: dataProduk.get("deskripsi"),
                            harga: dataProduk.get("harga"),
                            kategori: dataProduk.get("kategori"),
                            poster: dataProduk.get("poster"),
                            screenshot: dataProduk.get("screenshot"),
                            rating: dataProduk.get("rating"),
                          );
                        } else {
                          return SizedBox();
                        }
                      }).toList());
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            )));
  }
}
