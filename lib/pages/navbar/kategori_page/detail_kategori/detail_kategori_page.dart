import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/kategori_page/kategori_card.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_card.dart';
import 'package:test_aplikasi/utils/constant.dart';

class DetailKategoriPage extends StatefulWidget {
  const DetailKategoriPage({super.key});

  @override
  State<DetailKategoriPage> createState() => _DetailKategoriPageState();
}

class _DetailKategoriPageState extends State<DetailKategoriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Kategori"),
      ),
      body: Column(
        children: [ProdukCard(), ProdukCard(), ProdukCard()],
      ),
    );
  }
}
