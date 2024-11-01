import 'dart:convert';

import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isLoading = true;
  void initState() {
    super.initState();
    fetchIfEmpty();
  }

  void fetchIfEmpty() {
    if (ref.read(productProvider).isEmpty) {
      fetchProducts();
    }
  }

  Future<void> fetchProducts() async {
    final resp = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (resp.statusCode == 200) {
      Iterable list = jsonDecode(resp.body);
      List<Products> products =
          List<Products>.from(list.map((e) => Products.fromJson(e)));
      ref.read(productProvider.notifier).setProducts(products);
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      throw Exception('Failed to load the products!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/splash_bg.png'),
              Positioned(
                top: 412,
                left: 128,
                child: Center(
                  child: Container(
                      height: 134,
                      width: 134,
                      child: SvgPicture.asset('assets/icons/splash_logo.svg')),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 90,
          ),
          isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 6,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
