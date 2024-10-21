import 'package:ecommerce_app/provider/product.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(productProvider);
    var products = ref.read(productProvider.notifier);
    var savedItems = products.favourites;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 24, right: 24),
        child: Column(
          children: [
            NavBar(label: "Saved Items"),
            SizedBox(height: 24),
            GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.50, // Adjust this value as needed
              ),
              itemBuilder: (context, index) => ProductTile(
                product: savedItems[index],
              ),
              itemCount: savedItems.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      )),
    );
  }
}
