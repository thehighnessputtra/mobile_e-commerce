import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/home_page/home_page.dart';
import 'package:test_aplikasi/pages/navbar/kategori_page/kategori_page.dart';
import 'package:test_aplikasi/pages/navbar/laporan_page/laporan_page.dart';
import 'package:test_aplikasi/pages/navbar/produk_page/produk_page.dart';
import 'package:test_aplikasi/pages/navbar/profile_page/profile_page.dart';
import 'package:test_aplikasi/utils/constant.dart';

class NavBottomBar extends StatefulWidget {
  NavBottomBar({super.key, this.currentIndex = 0});
  @override
  State<NavBottomBar> createState() => _NavBottomBarState();

  int currentIndex = 0;
}

class _NavBottomBarState extends State<NavBottomBar> {
  final List<Widget> screens = [
    const HomePage(),
    const ProdukPage(),
    const KategoriPage(),
    const ProfilePage(),
    const LaporanPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[widget.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.yellowAccent,
            unselectedItemColor: lightBlueColor,
            iconSize: 25,
            currentIndex: widget.currentIndex,
            onTap: (index) => setState(() => widget.currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_rounded),
                label: 'Produk',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Kategori',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_document),
                label: 'Laporan',
              ),
            ]));
  }
}
