import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/detail_produk/detail_produk_page.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_card.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('produkList').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListProdukPage(
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

class ListProdukPage extends StatefulWidget {
  final List<DocumentSnapshot> listProduk;
  int itemCount;
  bool setCount;
  ListProdukPage(
      {super.key,
      required this.listProduk,
      this.itemCount = 1,
      this.setCount = false});

  @override
  State<ListProdukPage> createState() => _ListProdukPageState();
}

class _ListProdukPageState extends State<ListProdukPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount:
            widget.setCount ? widget.itemCount : widget.listProduk.length,
        itemBuilder: (context, index) {
          final itemsList = widget.listProduk[index];
          String storageNama = itemsList['nama'];
          String storagePoster = itemsList['poster'];
          int storageHarga = itemsList['harga'];
          num storageRating = itemsList['rating'];
          String storageDeskripsi = itemsList['deskripsi'];
          List storageKategori = itemsList['kategori'];
          List storageScreenshot = itemsList['screenshot'];

          return ProdukCard(
            poster: storagePoster,
            harga: storageHarga,
            rating: storageRating,
            deskripsi: storageDeskripsi,
            screenshot: storageScreenshot,
            nama: storageNama,
            kategori: storageKategori,
          );
        });
  }
}
