import 'package:flutter/material.dart';
import 'package:tuma/data/workerInfo.dart';
import 'package:tuma/screens/workerDetail.dart';
import 'package:tuma/widgets/cardWidget.dart';
import 'package:tuma/widgets/workerInfoCard.dart';

class ConstructionScreen extends StatefulWidget {
  ConstructionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ConstructionScreenState createState() => _ConstructionScreenState();
}

class _ConstructionScreenState extends State<ConstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              backgroundColor: Colors.orangeAccent,
              elevation: 0,
              expandedHeight: (MediaQuery.of(context).size.height / 2),
              pinned: true,
              leading: Padding(
                padding: EdgeInsets.all(8.0),
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
              title: Text("View Workers "),
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
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 85,
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
                                  Text(
                                    "Construction",
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
                                  Text(
                                    'Construction profesionals ',
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
                                        "${workerInfo.length} Workers Availlable",
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
                                      primary: Colors.orange,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Working Hours: 24 hour service",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
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
                          image: AssetImage("assets/images/construction.jpg"),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.darken),
                          fit: BoxFit.cover)),
                ),
              )),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
                  child: Text("Construction Professionals",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 5)),
                  itemCount: workerInfo.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => InkWell(
                    child: WorkerInfoCard(
                        name: "${workerInfo[index]['workername']}",
                        imgUrl: "${workerInfo[index]['img']}",
                        location: "${workerInfo[index]['location']}",
                        description: "${workerInfo[index]['description']}"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WorkerDetails(
                              name: "${workerInfo[index]['workername']}",
                              imgUrl: "${workerInfo[index]['img']}",
                              location: "${workerInfo[index]['location']}",
                              description:
                                  "${workerInfo[index]['description']}")));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
