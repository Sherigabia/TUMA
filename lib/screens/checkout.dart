import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool processing = false;
  var publicKey = 'sk_test_63ef2bcbc3f29fb4556bd02f2f6cf0100bf46926';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    final payButton = Material(
        elevation: 3,
        color: Color.fromRGBO(41, 205, 195, 1),
        borderRadius: BorderRadius.circular(5),
        child: MaterialButton(
            onPressed: () {},
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
        title: Text("CheckOut"),
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
        child: Container(
            child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("PLEASE COMPLETE SERVICE REQUEST",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                children: [
                  Text("Make", style: TextStyle(fontWeight: FontWeight.w500)),
                  Text("Complete", style: TextStyle(color: Colors.grey)),
                  Text("Confirm", style: TextStyle(color: Colors.grey))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Request",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    "Service Payment",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(" Completion", style: TextStyle(color: Colors.grey))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Client Name : "),
                          SizedBox(width: 40),
                          Text("Samirah Osman")
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
                          Text("Area 3 ,Sunyani Bono")
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
                          Text("Plumbing Service")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Estimated Hours : "),
                          SizedBox(width: 80),
                          Text("3 Hours")
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
                  )),
              SizedBox(height: 10),
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
                      Text("Payment Information",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Job Request Charge : "),
                          SizedBox(width: 40),
                          Text("GHC 10.00")
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
                          Text("GHC 1.00")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Charge : ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          SizedBox(width: 30),
                          Text("GHC 11.00",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ],
                  )),
              SizedBox(
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
        )),
      ),
    );
  }
  // Paystack Key
  // sk_test_63ef2bcbc3f29fb4556bd02f2f6cf0100bf46926

}
