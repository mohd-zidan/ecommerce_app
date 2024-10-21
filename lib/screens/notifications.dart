import 'package:ecommerce_app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    List<List<String>> notifications = [];
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: notifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 12),
                    NavBar(label: "Notifications"),
                    SizedBox(height: 24),
                    Divider(
                      color: Color(0xffE6E6E6),
                    ),
                    SizedBox(height: 220),
                    SvgPicture.asset(
                      'assets/icons/bell-big.svg',
                      width: 48,
                      height: 52,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "You haven't gotten any\nnotifications yet!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(
                        "We'll alert you when something\ncool happens.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff808080),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {},
                ),
        ),
      ),
    );
  }
}
