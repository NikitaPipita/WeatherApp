import 'package:flutter/material.dart';

class DetailInfoGridTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final bool underlined;

  DetailInfoGridTile({
    @required this.icon,
    @required this.title,
    @required this.info,
    @required this.underlined,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: underlined ? Colors.grey : Colors.transparent,
              ),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: Colors.blue,
            ),
            SizedBox(
              width: 4.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  info,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}