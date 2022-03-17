import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/subaccount.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({Key? key}) : super(key: key);

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";

  bool isTestMode = true;
  final pbk = "FLWPUBK_TEST";

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Payment"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Amount is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: currencyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: _openBottomSheet,
                  decoration: InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Currency is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: publicKeyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Public Key",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: encryptionKeyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Encryption Key",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isTestMode = value;
                        })
                      },
                      value: isTestMode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: RaisedButton(
                  onPressed: _onPressed,
                  color: Colors.blue,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "My Standard Blue",
      buttonColor: Color(0xffd0ebff),
      buttonTextStyle: TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 16,
      ),
      appBarColor: Color(0xff8fa33b),
      dialogCancelTextStyle: TextStyle(
        color: Colors.brown,
        fontSize: 18,
      ),
      dialogContinueTextStyle: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.indigo,
      mainTextStyle:
          TextStyle(color: Colors.indigo, fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: Colors.greenAccent,
      appBarIcon: Icon(Icons.message, color: Colors.purple),
      buttonText: "Pay $selectedCurrency${amountController.text}",
      appBarTitleTextStyle: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: "FLW Developer",
        phoneNumber: phoneNumberController.text,
        email: "customer@customer.com");

    final subAccounts = [
      SubAccount(
          id: "RS_1A3278129B808CB588B53A14608169AD",
          transactionChargeType: "flat",
          transactionPercentage: 25),
      SubAccount(
          id: "RS_C7C265B8E4B16C2D472475D7F9F4426A",
          transactionChargeType: "flat",
          transactionPercentage: 50)
    ];

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: publicKeyController.text.trim().isEmpty
            ? getPublicKey()
            : publicKeyController.text.trim(),
        currency: selectedCurrency,
        txRef: "2115454565",
        amount: amountController.text.toString().trim(),
        customer: customer,
        subAccounts: subAccounts,
        paymentOptions: "card, payattitude",
        customization: Customization(title: "Test Payment"),
        redirectUrl: "https://www.google.com",
        isTestMode: false);
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      showLoading(response.status!);
      print("${response.toJson()}");
    } else {
      showLoading("No Response!");
    }
  }

  String getPublicKey() {
    if (isTestMode) return "FLWPUBK_TEST-02b9b5fc6406bd4a41c3ff141cc45e93-X";
    return "FLWPUBK-X";
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["NGN", "RWF", "UGX", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {_handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
