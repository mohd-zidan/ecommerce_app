import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartProvider);
    var distinctCartProducts = cartProducts.toSet();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(top: 12, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavBar(label: "My Cart"),
                SizedBox(height: 20),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: distinctCartProducts.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CartTile(
                      product: distinctCartProducts.elementAt(index),
                      count: cartProducts
                          .where((element) =>
                              element.id ==
                              distinctCartProducts.elementAt(index).id)
                          .length,
                    );
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'Sub-total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff808080),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$ ${ref.read(cartProvider.notifier).totalPrice.toStringAsPrecision(3)}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff808080)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'VAT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff808080),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$ 0.00',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff808080)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Shipping',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff808080),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$ 0.0',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff808080)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$ ${ref.read(cartProvider.notifier).totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartTile extends ConsumerStatefulWidget {
  const CartTile({super.key, required this.product, required this.count});

  final Products product;
  final int count;

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends ConsumerState<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE6E6E6)),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 84,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Image(image: NetworkImage(widget.product.image!)),
          ),
          SizedBox(width: 16),
          Expanded(
            // Ensure that the Column doesn't overflow
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align to the start
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min, // Prevent Row from expanding
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.title!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => ref
                          .read(cartProvider.notifier)
                          .clearfromCart(widget.product.id!),
                      child: Container(
                        height: 16,
                        width: 16,
                        child: SvgPicture.asset('assets/icons/delete.svg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8), // Provide spacing between the two rows
                Row(
                  children: [
                    Text(
                      '\$ ${widget.product.price}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => widget.count <= 1
                          ? ()
                          : ref
                              .read(cartProvider.notifier)
                              .removeProduct(widget.product),
                      child: Container(
                        height: 24,
                        width: 24,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Color(0xffCCCCCC)),
                        ),
                        child: SvgPicture.asset('assets/icons/minus.svg'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${widget.count}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => ref
                          .read(cartProvider.notifier)
                          .addProduct(widget.product),
                      child: Container(
                        height: 24,
                        width: 24,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Color(0xffCCCCCC)),
                        ),
                        child: SvgPicture.asset('assets/icons/plus.svg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
