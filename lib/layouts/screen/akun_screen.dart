import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/login_screen.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: getHeight(160),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    children: [
                      Container(
                        height: getHeight(100),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image:
                              AssetImage('assets/images/background_tiket.jpg'),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ],
                  ),
                  Positioned(
                      left: getWidth(20),
                      top: getHeight(30),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: getHeight(60),
                            backgroundColor: kWhiteColor,
                            child: CircleAvatar(
                              radius: getHeight(55),
                              backgroundImage: AssetImage(
                                  'assets/images/background_tiket.jpg'),
                            ),
                          ),
                          CircleAvatar(
                            radius: getHeight(22),
                            backgroundColor: kWhiteColor,
                            child: CircleAvatar(
                              radius: getHeight(20),
                              backgroundColor: kOrangeColor,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: getHeight(18),
                                    color: kWhiteColor,
                                  )),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            itemProfile('Nama', 'Megawati Aswiya Putri', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile('No Telepon', '08880337892', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemProfile('Email', '19putrimega@gmail.com', CupertinoIcons.mail),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: getHeight(50),
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: kRedColor),
                child: Text(
                  'Keluar',
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kGreyColor.withOpacity(.5)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: kGreyColor.withOpacity(.1),
              spreadRadius: 1,
              blurRadius: 1,
            )
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: kWhiteColor,
      ),
    );
  }
}
