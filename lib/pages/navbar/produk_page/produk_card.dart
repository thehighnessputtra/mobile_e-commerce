import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/detail_produk/detail_produk_page.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class ProdukCard extends StatelessWidget {
  ProdukCard(
      {super.key,
      this.nama,
      this.kategori,
      this.poster,
      this.deskripsi,
      this.harga,
      this.screenshot,
      this.rating});
  String? nama;
  List? kategori;
  List? screenshot;
  int? harga;
  String? deskripsi;
  String? poster;
  num? rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: ListTile(
          onTap: () {
            navPushTransition(
                context,
                DetailProdukPage(
                  namaProduk: nama!,
                  deskripsi: deskripsi!,
                  harga: harga!,
                  poster: poster!,
                  kategori: kategori!,
                  screenshot: screenshot!,
                ));
          },
          title: Text(nama!, softWrap: true, maxLines: 2),
          tileColor: Colors.yellow,
          subtitle: Row(
              children: kategori!.map((e) {
            return Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.only(right: 4),
                color: Colors.redAccent,
                child: Text(
                  e,
                  style: kategoriTS,
                ));
          }).toList()),
          trailing: Text(NumberFormat.currency(
                  locale: 'id', symbol: 'RP ', decimalDigits: 0)
              .format(double.parse(harga!.toString()))),
          leading: Stack(children: [
            SizedBox(
              width: 50,
              child: Image.network(poster!, fit: BoxFit.fill),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(
                      "${rating!.toDouble()}",
                      style: bannerTS,
                    ),
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
