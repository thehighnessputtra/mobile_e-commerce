import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/utils/constant.dart';

class DetailProdukPage extends StatefulWidget {
  String namaProduk;
  String poster;
  int harga;
  List kategori;
  String deskripsi;

  List screenshot;
  DetailProdukPage(
      {super.key,
      required this.namaProduk,
      required this.harga,
      required this.kategori,
      required this.deskripsi,
      required this.poster,
      required this.screenshot});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.namaProduk),
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                widget.poster,
                fit: BoxFit.cover,
              ),
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
            sh5,
            CarouselSlider(
              items: widget.screenshot.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.yellow),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 70,
                aspectRatio: 16 / 9,
                viewportFraction: 0.4,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            sh10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.kategori.map((e) {
                return Container(
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(right: 4),
                    color: Colors.yellow,
                    child: Text(e));
              }).toList(),
            ),
            Text(widget.deskripsi)
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: StreamBuilder(
      //     stream:
      //         FirebaseFirestore.instance.collection('produkList').snapshots(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return DetailProduk(
      //           detailProduk: snapshot.data!.docs,
      //           namaProduk: widget.namaProduk,
      //         );
      //       }
      //       return const Center(child: CircularProgressIndicator());
      //     },
      //   );
      // ),
    );
  }
}

// class DetailProduk extends StatefulWidget {
//   final List<DocumentSnapshot> detailProduk;
//   String namaProduk;
//   DetailProduk(
//       {super.key, required this.detailProduk, required this.namaProduk});

//   @override
//   State<DetailProduk> createState() => _DetailProdukState();
// }

// class _DetailProdukState extends State<DetailProduk> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: widget.detailProduk.length,
//         itemBuilder: (context, index) {
//           final itemsList = widget.detailProduk[index];
//           String storageNama = itemsList['nama'];
//           String storageDeskripsi = itemsList['deskripsi'];
//           String storagePoster = itemsList['poster'];
//           int storageHarga = itemsList['harga'];
//           List storageKategori = itemsList['kategori'];
//           List storageScreenshot = itemsList['screenshot'];

//           // return
//           // SingleChildScrollView(
//           //     child: Column(
//           //       children: [
//           //         SizedBox(
//           //           child: Image.network(
//           //             storagePoster,
//           //             fit: BoxFit.cover,
//           //           ),
//           //           width: MediaQuery.of(context).size.width,
//           //           height: 200,
//           //         ),
//           //         sh5,
//           //         CarouselSlider(
//           //           items: storageScreenshot.map((i) {
//           //             return Builder(
//           //               builder: (BuildContext context) {
//           //                 return Container(
//           //                     width: MediaQuery.of(context).size.width,
//           //                     margin: const EdgeInsets.symmetric(
//           //                         horizontal: 5.0),
//           //                     decoration:
//           //                         const BoxDecoration(color: Colors.yellow),
//           //                     child: Image.network(
//           //                       i,
//           //                       fit: BoxFit.cover,
//           //                     ));
//           //               },
//           //             );
//           //           }).toList(),
//           //           options: CarouselOptions(
//           //             height: 70,
//           //             aspectRatio: 16 / 9,
//           //             viewportFraction: 0.4,
//           //             initialPage: 0,
//           //             enableInfiniteScroll: true,
//           //             reverse: false,
//           //             autoPlay: true,
//           //             autoPlayInterval: const Duration(seconds: 3),
//           //             autoPlayAnimationDuration:
//           //                 const Duration(milliseconds: 800),
//           //             autoPlayCurve: Curves.fastOutSlowIn,
//           //             scrollDirection: Axis.horizontal,
//           //           ),
//           //         ),
//           //         sh10,
//           //         Row(
//           //           mainAxisAlignment: MainAxisAlignment.start,
//           //           children: storageKategori.map((e) {
//           //             return Container(
//           //                 padding: const EdgeInsets.all(3),
//           //                 margin: const EdgeInsets.only(right: 4),
//           //                 color: Colors.yellow,
//           //                 child: Text(e));
//           //           }).toList(),
//           //         ),
//           //         Text(storageDeskripsi)
//           //       ],
//           //     ),
//           //   )
//         });
//   }
// }
