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
      this.screenshot});
  String? nama;
  List? kategori;
  List? screenshot;
  int? harga;
  String? deskripsi;
  String? poster;

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
          leading: SizedBox(
            height: 60,
            width: 60,
            child: Image.network(poster!, fit: BoxFit.fill),
          )),
    );
  }
}
