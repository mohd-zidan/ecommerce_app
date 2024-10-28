import 'dart:convert';
import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/provider/product.dart';
import 'package:ecommerce_app/screens/notifications.dart';
import 'package:ecommerce_app/screens/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController tabScrollController = ScrollController();
  bool isLoading = true;
  List tabs = [
    "All",
    "Men's clothing",
    "Jewelery",
    "Electronics",
    "Women's Clothing",
  ];
  String filter = "All";

  List<Products> filterProducts(List<Products> products, String option) {
    if (option == "All") {
      return products;
    } else {
      return products.where((e) => e.category == option.toLowerCase()).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    var products = ref.watch(productProvider);
    var filteredList = filterProducts(products, filter);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontFamily: "General Sans",
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.64, vertical: 1.88),
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset('assets/icons/bell.svg'),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Notifications())),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: 52,
                width: 342,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: 280,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffE6E6E6)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/search.svg',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for clothes...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SvgPicture.asset('assets/icons/mic.svg')
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.all(16),
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        height: 18,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) => TabSelector(
                    label: tabs[index],
                    isSelected: filter == tabs[index],
                    onTap: () {
                      setState(() {
                        print(filter);
                        filter = tabs[index];
                      });
                      filterProducts(products, filter);
                      print(filteredList);
                    },
                  ),
                ),
              ),
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
                  product: filteredList[index],
                ),
                itemCount: filteredList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabSelector extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onTap;
  const TabSelector({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffE6E6E6))),
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTile extends ConsumerStatefulWidget {
  final Products product;
  const ProductTile({
    super.key,
    required this.product,
  });

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends ConsumerState<ProductTile> {
  @override
  Widget build(BuildContext context) {
    var productTile = ref.watch(productProvider).firstWhere(
          (element) => element.id == widget.product.id,
        );
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        child: Container(
          width: constraints.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        widget.product.image!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x40525252),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: productTile.isFavourite!
                              ? SvgPicture.asset('assets/icons/fav-filled.svg')
                              : SvgPicture.asset('assets/icons/fav-active.svg'),
                        ),
                        onTap: () {
                          setState(
                            () {
                              ref
                                  .read(productProvider.notifier)
                                  .toggleFavourite(
                                    widget.product.id!,
                                  );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.product.title!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                "\$ ${widget.product.price!.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Color(0xff808080),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  productId: widget.product.id!,
                ))),
      );
    });
  }
}
