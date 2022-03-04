import 'package:flutter/material.dart';
import 'package:tuma/widgets/cardWidget.dart';

class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final workerInfo = [
    {
      "workername": "Dokorugu Ventures",
      "description": "Plumbing and general House services",
      "location": "Lamashegu - Tamale",
      "img": "assets/images/plumber1.jpg"
    },
    {
      "workername": "Sampson Lardi",
      "description": "General plumbing services",
      "location": "Tafo - Kumasi",
      "img": "assets/images/plumber2.jpg"
    },
    {
      "workername": "Boakye Consult",
      "description": "Best plumbing services",
      "location": "Abesim - Sunyani",
      "img": "assets/images/worker.jpg"
    },
    {
      "workername": "Boakye Consult",
      "description": "Best plumbing services",
      "location": "Abesim - Sunyani",
      "img": "assets/images/plumber3.jpg"
    },
    {
      "workername": "Boakye Consult",
      "description": "Best plumbing services",
      "location": "Abesim - Sunyani",
      "img": "assets/images/plumber4.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: Icon(Icons.shopping_cart, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 65,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Plumbers",
                                    style: const TextStyle(
                                        fontSize: 41,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Request the service of very experienced ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'plumbers from the comfort of your home ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "100 Workers Availlable",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      primary: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Working Hours: 24 hour service",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/worker.jpg"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.darken),
                          fit: BoxFit.cover)),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
            ),
            preferredSize: Size.fromHeight(300),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text("Available Plumbers",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CardWidget(
                                  name: "${workerInfo[index]['workername']}",
                                  imgUrl: "${workerInfo[index]['img']}",
                                  location: "${workerInfo[index]['location']}",
                                  description:
                                      "${workerInfo[index]['description']}")
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox();
                        },
                        itemCount: workerInfo.length),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
