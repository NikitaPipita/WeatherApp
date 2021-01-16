import 'package:flutter/material.dart';

class WeatherDetailInfoWidget extends StatelessWidget {
  final String description;
  final List<Widget> gridTiles;

  WeatherDetailInfoWidget({
    @required this.description,
    @required this.gridTiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 8.0,),
        Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 4),
              children: gridTiles,
            ),
          ),
        ),
      ],
    );
  }
}


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
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: Colors.blue,
            ),
            SizedBox(width: 4.0,),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
