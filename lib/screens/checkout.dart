import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:lottie/lottie.dart';
import 'package:tuma/Payment/payment_page.dart';
import 'package:tuma/screens/jobCompleted.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen>
    with SingleTickerProviderStateMixin {
  bool processing = false;
  String? _ref;
  late AnimationController controller;

  final String currency = FlutterwaveCurrency.GHS;
  final String amount = "200";
  void setRef() {
    Random rand = Random();
    int number = rand.nextInt(2000);
    if (Platform.isAndroid) {
      setState(() {
        _ref = "AndroidRef1021799$number";
      });
    } else {
      setState(() {
        _ref = "IOSRef1021799$number";
      });
    }
  }

  @override
  void initState() {
    setRef();
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
                Text(
                  "Payment Successful",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Text(
                        "An agent from TUMA",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Will get in touch with you shortly",
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
    final payButton = Material(
        elevation: 3,
        color: const Color.fromRGBO(41, 205, 195, 1),
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {
              makePayment(context);

              //  makePayment(context);
            },
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? const Text("Make Payment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))
                : const CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                    semanticsLabel: 'Loading ..',
                  )));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        title: const Text("CheckOut"),
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
                  Text("Please Complete Service Request",
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
                    backgroundColor: Colors.grey,
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
                  Text("Complete", style: TextStyle(color: Colors.grey)),
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
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(" Completion", style: TextStyle(color: Colors.grey))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              serviceInfoCard(
                estimatedHours: 5,
                username: "Febiri Mark",
                location: "Tafo Mile 4 - Kumasi",
                requestedJob: "Plumbing Service",
              ),
              const SizedBox(height: 10),
              paymentInfoCard(
                jobRequestCharge: 10,
                serviceRequestCharge: 0,
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "By clicking make payment, you agree to TUMA’s Terms of use and privacy policy",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  payButton
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void makePayment(BuildContext context) async {
    Flutterwave flutterwave = Flutterwave.forUIPayment(
      context: this.context,
      encryptionKey: "FLWSECK_TESTd463bf7bc2c4",
      publicKey: "FLWPUBK_TEST-ed59565b4bfa790d162becf27ea7c1d4-X",
      currency: currency,
      amount: amount,
      email: "febiri@email.com",
      fullName: "Febiri Mark",
      txRef: _ref!,
      isDebugMode: false,
      phoneNumber: "0553164027",
      acceptCardPayment: false,
      acceptUSSDPayment: true,
      acceptAccountPayment: false,
      acceptFrancophoneMobileMoney: false,
      acceptGhanaPayment: true,
    );

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
          showDoneDialog();
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data!.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data!.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data!.currency == this.currency &&
        response.data!.amount == this.amount &&
        response.data!.txRef == _ref;
  }
}
// Paystack Key
// sk_test_63ef2bcbc3f29fb4556bd02f2f6cf0100bf46926

class paymentInfoCard extends StatelessWidget {
  int jobRequestCharge;
  double serviceRequestCharge;

  paymentInfoCard(
      {Key? key,
      required this.jobRequestCharge,
      required this.serviceRequestCharge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text("Payment Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Job Request Charge : "),
                SizedBox(width: 40),
                Text('$jobRequestCharge')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Service Charge : "),
                SizedBox(width: 30),
                Text('${jobRequestCharge * 10 / 100}')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Charge : ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                SizedBox(width: 30),
                Text(_totalCharge(jobRequestCharge, serviceRequestCharge),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
              ],
            ),
          ],
        ));
  }

  _totalCharge(int jobCharge, double serviceCharge) {
    serviceRequestCharge = jobRequestCharge * 10 / 100;
    double totalcharge = jobCharge + serviceRequestCharge;
    return totalcharge.toString();
  }
}

class serviceInfoCard extends StatelessWidget {
  String username;
  String location;
  String requestedJob;
  int estimatedHours;

  serviceInfoCard({
    required this.username,
    required this.location,
    required this.requestedJob,
    required this.estimatedHours,
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
            Text("Service Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Client Name : "),
                SizedBox(width: 40),
                Text(username)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Client Location : "),
                SizedBox(width: 30),
                Text(location)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Service Request : "),
                SizedBox(width: 30),
                Text(requestedJob)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Estimated Hours : "),
                SizedBox(width: 80),
                Text('$estimatedHours Hours')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Payment Method : "),
                SizedBox(width: 50),
                Text("MTN MOBILE MONEY")
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
