import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_aplikasi/services/firebase_services.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/dialog_widget.dart';

class LaporanCard extends StatelessWidget {
  LaporanCard({super.key, required this.harga, required this.nama});
  String nama;
  int harga;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: ListTile(
        onTap: () {
          customDialog(confirmButton: true, yesPressed: () {
            FirebaseService(FirebaseAuth.instance).deleteFromKeranjang(
                email: FirebaseAuth.instance.currentUser!.email!,
                totalHarga: harga,
                totalGame: nama,
                context: context);
            Navigator.pop(context);
          }, context,
              title: "KONFIRMASI",
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Apakah yakin ingin membatalkan pembelian item $nama?",
                      style: dialogContentTS,
                    )
                  ],
                ),
              ));
        },
        title: Text(nama, softWrap: true, maxLines: 2, style: kategoriTS),
        tileColor: Colors.yellow,
        trailing: Text(
            NumberFormat.currency(locale: 'id', symbol: 'RP ', decimalDigits: 0)
                .format(double.parse(harga.toString()))),
      ),
    );
  }
}
