import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/saved.dart';
import 'package:ecommerce_app/screens/search.dart';
import 'package:ecommerce_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Stop',
      theme: ThemeData(
          colorScheme: ColorScheme.light(primary: Colors.black),
          useMaterial3: true,
          fontFamily: "General Sans"),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    SavedPage(),
    CartPage(),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 24,
              width: 24,
            ),
            label: "Home",
            activeIcon: SvgPicture.asset(
              'assets/icons/home-active.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search-bottom.svg',
              height: 24,
              width: 24,
            ),
            label: "Search",
            activeIcon: SvgPicture.asset(
              'assets/icons/search-black.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/fav.svg',
              height: 24,
              width: 24,
            ),
            label: "Saved",
            activeIcon: SvgPicture.asset(
              'assets/icons/fav-active.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              height: 24,
              width: 24,
            ),
            label: "Cart",
            activeIcon: SvgPicture.asset(
              'assets/icons/cart-active.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/account.svg',
              height: 24,
              width: 24,
            ),
            label: "Account",
            activeIcon: SvgPicture.asset(
              'assets/icons/account-active.svg',
              height: 24,
              width: 24,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
