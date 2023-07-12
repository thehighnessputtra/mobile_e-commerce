import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/kategori_page/detail_kategori/detail_kategori_page.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/detail_produk/detail_produk_page.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class KategoriCard extends StatelessWidget {
  KategoriCard({super.key, required this.namaKategori, required this.listGame});
  String namaKategori = '...';
  List listGame = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: ListTile(
        onTap: () {
          navPushTransition(
              context,
              DetailKategoriPage(
                namaKategori: namaKategori,
                listGame: listGame,
              ));
        },
        title: Text(namaKategori),
        tileColor: Colors.yellow,
      ),
    );
  }
}
