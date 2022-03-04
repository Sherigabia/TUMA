import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String location;
  final String description;
  const CardWidget(
      {Key? key,
      required this.name,
      required this.imgUrl,
      required this.location,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: InkWell(
          onTap: () {
            //navigate to the detail screen of this worker
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgUrl), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                SizedBox(width: 20.0),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
