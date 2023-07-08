import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/detail_produk/detail_produk_page.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class ProdukCard extends StatelessWidget {
  const ProdukCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        navPushTransition(context, DetailProdukPage());
      },
      title: Text("Test"),
      style: ListTileStyle.list,
      tileColor: Colors.yellow,
      subtitle: Text("Kategori"),
      trailing: Text("10.000"),
      leading: SizedBox(
          height: 60, width: 60, child: Card(color: Colors.blue, elevation: 0)),
    );
  }
}
