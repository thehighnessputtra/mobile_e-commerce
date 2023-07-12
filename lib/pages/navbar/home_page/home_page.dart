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
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("produkList").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CarouselSlider(
                  items: snapshot.data!.docs.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                            child: Stack(children: [
                          Image(
                            image: NetworkImage("${i.get("screenshot")[0]}"),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black.withOpacity(0.8),
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                i.get("nama"),
                                style: bannerTS,
                              ),
                            ),
                          )
                        ]));
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          sh20,
          Text(
            "TOP RATING",
            style: subTS,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('produkList')
                .orderBy("rating", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListProdukPage(
                  setCount: true,
                  itemCount: 3,
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
