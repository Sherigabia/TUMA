import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tuma/screens/checkout.dart';
import 'package:tuma/widgets/basicGridView.dart';

class WorkerDetails extends StatefulWidget {
  String name;
  String location;
  String description;
  String imgUrl;
  WorkerDetails(
      {Key? key,
      required this.name,
      required this.location,
      required this.description,
      required this.imgUrl})
      : super(key: key);

  @override
  State<WorkerDetails> createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future makeRequestDialog() {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
                title: Text(
                  "Request Service Worker",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                content: Text("Do you want to proceed with your request ?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      print("requested");
                      Navigator.of(context).pop(false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutScreen()));
//                      showDoneDialog();
                      // setState(() {
                      //   loading = true;
                      //   updateRequest = true;
                      // });
                    },
                    child: Text("YES"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("CANCEL"))
                ]));
  }

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
            title: Text(
              "Worker Details",
              style: TextStyle(color: Colors.white),
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
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                      fontSize: 41,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.description,
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
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.location,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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
                                        fontSize: 16, color: Colors.black),
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
                        image: AssetImage(widget.imgUrl),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.darken),
                        fit: BoxFit.cover)),
              ),
            ),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         bottomRight: Radius.circular(50),
            //         bottomLeft: Radius.circular(50))),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 18, 16.0, 0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.task_outlined,
                                  size: 45,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("30 Jobs Completed",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Spacer(),
                            TextButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Color.fromRGBO(41, 205, 195, 1),
                                ),
                                onPressed: () {
                                  makeRequestDialog();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Request Service",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.task_alt_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.star),
                                ),
                                SizedBox(height: 5),
                                Text("Reviews")
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.message),
                                ),
                                SizedBox(height: 5),
                                Text("Send Message")
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(child: Icon(Icons.bookmark_add)),
                                SizedBox(height: 5),
                                Text("Bookmark")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Sample Works",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        // GridView Goes here
                        BasicGridWidget(
                          imgUrl: widget.imgUrl,
                        )
                      ],
                    ),
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
