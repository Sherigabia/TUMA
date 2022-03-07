import 'package:flutter/material.dart';
import 'package:tuma/screens/job.dart';
import 'package:tuma/screens/workPage.dart';
import 'package:tuma/widgets/categoriesList.dart';
import 'package:tuma/widgets/creditCard.dart';
import 'package:tuma/widgets/searchInput.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isDarkModeEnabled = false;
  final workers = [
    {'jobTitle': 'Catering', 'img': "assets/images/catering.jpeg"},
    {'jobTitle': 'Delivery', 'img': "assets/images/delivery.jpeg"},
    {'jobTitle': 'Plumbing', 'img': "assets/images/plumber4.jpg"},
    {"jobTitle": 'Photography', 'img': "assets/images/photographer.jpeg"},
    {'jobTitle': 'Beautician', 'img': "assets/images/beautician.jpeg"},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF253341)),
        scaffoldBackgroundColor: const Color(0xFF15202B),
      ),
      themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          drawer: SideNavigation(
            imgUrl: "assets/images/delivery.jpeg",
            username: "Pambo",
            requestCount: 2,
          ),
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    ScaffoldState().openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black54,
                    size: 40,
                  )),
              const Spacer(),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5rxeMceKRHzUgy8DFjjk0D0JIXSMW5LBQeg&usqp=CAU'),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
            bottom: PreferredSize(
                child: Column(children: const [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RoundedSearchInput(hintText: 'search job')),
                  ),
                ]),
                preferredSize: Size.fromHeight(70)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          const CategoriesList(),
                          const Text(
                            "Available Services",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WorkPage(
                                                        jobImgUrl:
                                                            '${workers[index]['img']}',
                                                        jobTitle:
                                                            '${workers[index]['jobTitle']}',
                                                      )));
                                        },
                                        child: CreditCard(
                                          jobTitle:
                                              "${workers[index]['jobTitle']} Services",
                                          onTopRightButtonClicked: () {},
                                          imgUrl: "${workers[index]['img']}",
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemCount: workers.length),
                          )
                        ],
                      ),
                    )),
          ),
        ),
      ),
    );
  }

  /// Called when the state (day / night) has changed.
  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}

class SideNavigation extends StatelessWidget {
  String imgUrl;
  String username;
  int requestCount;

  SideNavigation(
      {Key? key,
      required this.imgUrl,
      required this.username,
      required this.requestCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 500,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.jpeg"),
                        fit: BoxFit.cover)),
                child: Column(children: [
                  Container(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(backgroundImage: AssetImage(imgUrl))),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              )),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),
          const ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favorites"),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("My Service Requests"),
            trailing: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                "$requestCount",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
