import 'package:flutter/material.dart';

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({Key? key}) : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: [
            DrawerHeader(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 500,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.jpeg"),
                          fit: BoxFit.cover)),
                  child: Column(children: [
                    Container(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/delivery.jpeg"))),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Sherigabia Pambo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                )),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favorites"),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("My Service Requests"),
              trailing: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  "6",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
