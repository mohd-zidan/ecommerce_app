import 'package:ecommerce_app/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  final String label;
  const NavBar({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      height: 32,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.64, vertical: 1.88),
              height: 24,
              width: 24,
              child: SvgPicture.asset('assets/icons/left-arrow.svg'),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontFamily: "SanFransico Pro",
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.64, vertical: 1.88),
              height: 24,
              width: 24,
              child: SvgPicture.asset('assets/icons/bell.svg'),
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Notifications())),
          ),
        ],
      ),
    );
  }
}
