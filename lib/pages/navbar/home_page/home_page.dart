import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_page.dart';
import 'package:test_aplikasi/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("produkList").snapshots(),
            builder: (context, snapshot) {
              return CarouselSlider(
                items: snapshot.data!.docs.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image(
                            image: NetworkImage("${i.get("screenshot")[0]}"),
                            fit: BoxFit.cover,
                          ));
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
          ),
          sh20,
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('produkList').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListProdukPage(
                  setCount: true,
                  itemCount: 1,
                  listProduk: snapshot.data!.docs,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ]),
      ),
    );
  }
}
