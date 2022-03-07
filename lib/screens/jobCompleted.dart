import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:lottie/lottie.dart';
import 'package:tuma/Payment/payment_page.dart';
import 'package:tuma/screens/jobCompletedReview.dart';

class JobCompletedScreen extends StatefulWidget {
  const JobCompletedScreen({Key? key}) : super(key: key);

  @override
  _JobCompletedScreenState createState() => _JobCompletedScreenState();
}

class _JobCompletedScreenState extends State<JobCompletedScreen>
    with SingleTickerProviderStateMixin {
  bool processing = false;
  String? _ref;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showDoneDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/images/Success.json',
                    repeat: false,
                    height: 100,
                    width: 100,
                    controller: controller, onLoaded: (composition) {
                  controller.forward();
                }),
                const Text(
                  "Job Completed",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Text(
                        "Thank you for using our Service",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "An agent will get in touch with you shortly",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ));
  @override
  Widget build(BuildContext context) {
    final completedButton = Material(
        elevation: 3,
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {
              showDoneDialog();
              Timer(
                  Duration(seconds: 4),
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => JobReviewScreen())));
              //  makePayment(context);
            },
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? const Text("COMPLETED",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))
                : const CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    semanticsLabel: 'Loading ..',
                  )));
    final reportButton = Material(
        elevation: 3,
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {
              showDoneDialog();
              //  makePayment(context);
            },
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? const Text("REPORT CONCERN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))
                : const CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                    semanticsLabel: 'Loading ..',
                  )));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        title: const Text("Confirm Job"),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: const Icon(Icons.star, color: Colors.white),
                ),
                // const SizedBox(
                //   width: 10,
                // ),
                // CircleAvatar(
                //   backgroundColor: Colors.black.withOpacity(0.4),
                //   child: Icon(Icons.shopping_cart, color: Colors.white),
                // )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Please Confirm Job Completion",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Make", style: TextStyle(fontWeight: FontWeight.w500)),
                  Text("Complete",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text("Confirm", style: TextStyle(color: Colors.grey))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Request",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    "Service Payment",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(" Completion", style: TextStyle(color: Colors.grey))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              serviceInfoCard(
                workerName: "Boadi Consult",
                paymentStatus: "Paid",
                jobStatus: "Pending",
                location: "Tafo Mile 4 - Kumasi",
                requestedJob: "Plumbing Service",
              ),
              const SizedBox(height: 10),
              Container(
                  width: 400,
                  height: 150,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Leave a Review",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: 50,
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "By clicking Completed, you agree to TUMA’s Terms of use and privacy policy",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  completedButton,
                  const SizedBox(
                    height: 20,
                  ),
                  reportButton
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class serviceInfoCard extends StatelessWidget {
  String workerName;
  String location;
  String requestedJob;
  String jobStatus;
  String paymentStatus;

  serviceInfoCard({
    required this.workerName,
    required this.location,
    required this.requestedJob,
    required this.jobStatus,
    required this.paymentStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 200,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service Status",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Service Worker : "),
                SizedBox(width: 40),
                Text(workerName)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Job Request : "),
                SizedBox(width: 30),
                Text(requestedJob)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Location : "),
                SizedBox(width: 30),
                Text(location)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Job Status : "),
                SizedBox(width: 175),
                Text(
                  jobStatus,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Payment Status : "),
                SizedBox(width: 165),
                Text(
                  paymentStatus,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
