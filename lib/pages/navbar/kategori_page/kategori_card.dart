import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/kategori_page/detail_kategori/detail_kategori_page.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class KategoriCard extends StatelessWidget {
  const KategoriCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        navPushTransition(context, DetailKategoriPage());
      },
      title: Text("Kategori"),
      style: ListTileStyle.list,
      tileColor: Colors.yellow,
      leading: SizedBox(
          height: 60, width: 60, child: Card(color: Colors.blue, elevation: 0)),
    );
  }
}
