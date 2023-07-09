import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/kategori_page/kategori_card.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        KategoriCard(),
        KategoriCard(),
        KategoriCard(),
      ]),
    );
  }
}
