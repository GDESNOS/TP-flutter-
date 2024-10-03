import 'package:flutter/material.dart';

class PersonContact extends StatelessWidget {
  String image;
  Text userName;
  Text number;
  Icon icon;
  PersonContact(
      {required this.image,
      required this.userName,
      required this.number,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userName,
                number,
              ],
            )
          ],
        ),
        icon,
      ],
    );
  }
}
