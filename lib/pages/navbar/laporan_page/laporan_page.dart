import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_aplikasi/pages/navbar/laporan_page/laporan_card.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_card.dart';
import 'package:test_aplikasi/services/firebase_services.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("keranjang").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                if (data.get("email") ==
                    FirebaseAuth.instance.currentUser!.email!) {
                  return Column(
                    children: [
                      Text(data.get("email")),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.get("totalGame").length,
                        itemBuilder: (context, index) {
                          final gameData = data.get("totalGame")[index];
                          final hargaData = data.get("totalHarga")[index];
                          return LaporanCard(
                            nama: gameData,
                            harga: hargaData,
                          );
                        },
                      ),
                      Text(
                          "TOTAL BELANJA ${NumberFormat.currency(locale: 'id', symbol: 'RP ', decimalDigits: 0).format(double.parse(data.get("totalHarga").fold(0, (previousValue, element) => previousValue + element).toString()))}")
                    ],
                  );
                } else {
                  return SizedBox();
                }

                Column(
                  children: [
                    Text(data.get("email")),
                    Text(FirebaseAuth.instance.currentUser!.email!),
                    Text(FirebaseAuth.instance.currentUser!.email!),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.get("totalGame").length,
                      itemBuilder: (context, index) {
                        final gameData = data.get("totalGame")[index];
                        final hargaData = data.get("totalHarga")[index];
                        return LaporanCard(
                          nama: gameData,
                          harga: hargaData,
                        );
                      },
                    ),
                    Text(
                        "TOTAL BELANJA ${NumberFormat.currency(locale: 'id', symbol: 'RP ', decimalDigits: 0).format(double.parse(data.get("totalHarga").fold(0, (previousValue, element) => previousValue + element).toString()))}")
                  ],
                );
                // } else {
                //   Text("ERROR");
                // }
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    ));
  }
}
