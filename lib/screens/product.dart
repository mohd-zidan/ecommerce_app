import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/provider/product.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ProductPage extends ConsumerStatefulWidget {
  final int productId;
  const ProductPage({
    super.key,
    required this.productId,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider).firstWhere(
          (element) => element.id == widget.productId,
        );
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(top: 12, left: 24, right: 24),
          child: Column(
            children: [
              NavBar(label: "Details"),
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 368,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(0, 108, 108, 108)
                                .withOpacity(0.5),
                            blurRadius: 6)
                      ],
                    ),
                    child: Image.network(
                      product.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 48,
                        width: 48,
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
                        child: product.isFavourite!
                            ? SvgPicture.asset('assets/icons/fav-filled.svg')
                            : SvgPicture.asset('assets/icons/fav-active.svg'),
                      ),
                      onTap: () {
                        ref
                            .read(productProvider.notifier)
                            .toggleFavourite(product.id!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                product.title!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: "General Sans",
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffFFA928),
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text("${product.rating!.rate.toString()}/5",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontFamily: "General Sans",
                      )),
                ],
              ),
              SizedBox(height: 12),
              Text(
                product.description!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "General Sans",
                    color: Color(0xff808080)),
              ),
              Spacer(),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "General Sans",
                            color: Color(0xff808080),
                          ),
                        ),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            fontFamily: "General Sans",
                            color: Color(0xff000000),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 32),
                    Center(
                      child: ref.watch(cartProvider).contains(product)
                          ? GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              ),
                              child: Container(
                                height: 54,
                                width: 240,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/cart-active.svg',
                                      height: 24,
                                      width: 24,
                                      colorFilter: ColorFilter.mode(
                                          Colors.white, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Go to Cart",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "General Sans",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => ref
                                  .read(cartProvider.notifier)
                                  .addProduct(product),
                              child: Container(
                                height: 54,
                                width: 240,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/bag.svg',
                                        height: 24, width: 24),
                                    SizedBox(width: 10),
                                    Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "General Sans",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
