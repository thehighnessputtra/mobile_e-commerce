import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_card.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ProdukCard(),
        ProdukCard(),
        ProdukCard(),
      ]),
    );
  }
}
