import 'dart:convert';
import 'package:credit_card_project/login.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreditCardsPage extends StatefulWidget {
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> {
  double i = -30;

  List s = [
    [Color(0xFF090943), "08/2022", "HOUSSEM SELMI", "3546 7532 XXXX 9742"],
    [Color(0xFF000000), "05/2024", "HOUSSEM SELMI", "9874 4785 XXXX 6548"]
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    i = -30;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitleSection(
                title: "Payment Details",
                subTitle: "How would you like to pay ?"),
            Container(
              height: 500,
              //width: double.maxFinite,
              child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: List.generate(s.length, (index) {
                    return _buildCreditCard(
                        // index: index,
                        color: s[index][0],
                        cardExpiration: s[index][1],
                        cardHolder: s[index][2],
                        cardNumber: s[index][3]);
                  })
                  // [
                  //   _buildCreditCard(
                  //       color: Color(0xFF090943),
                  //       cardExpiration: "08/2022",
                  //       cardHolder: "HOUSSEM SELMI",
                  //       cardNumber: "3546 7532 XXXX 9742"),
                  //   _buildCreditCard(
                  //       color: Color(0xFF000000),
                  //       cardExpiration: "05/2024",
                  //       cardHolder: "HOUSSEM SELMI",
                  //       cardNumber: "9874 4785 XXXX 6548"),
                  // ],
                  ),
            ),
            _buildAddCardButton(
              icon: Icon(Icons.add),
              color: Color(0xFF081603),
            ),
          ],
        ),
      ),
    );
  }

  // Build the title section
  Row _buildTitleSection({@required title, @required subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16.0),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Text(
                '$subTitle',
                style: TextStyle(fontSize: 21, color: Colors.black45),
              ),
            )
          ],
        ),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF090943))),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Login();
              }), ModalRoute.withName('/'));
            },
            child: Text("Logout"))
      ],
    );
  }

  // Build the credit card widget
  Widget _buildCreditCard({
    @required Color color,
    @required String cardNumber,
    @required String cardHolder,
    @required String cardExpiration,
    // @required int index
  }) {
    i = i + 30;
    return Padding(
      padding: EdgeInsets.only(top: i),
      child: Card(
        elevation: 4.0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          height: 200,
          // width: double.maxFinite,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildLogosBlock(),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  '$cardNumber',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'CourrierPrime'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildDetailsBlock(
                    label: 'CARDHOLDER',
                    value: cardHolder,
                  ),
                  _buildDetailsBlock(
                      label: 'VALID THRU', value: cardExpiration),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          "assets/images/mastercard.png",
          height: 50,
          width: 50,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({@required String label, @required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Future imagepick() async {
    try {
      XFile pickedfile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedfile != null) {
        setState(() {
          if (s.length.isEven) {
            s.add(
              [
                Color(0xFF090943),
                "08/2022",
                "HOUSSEM SELMI",
                "3546 7532 XXXX 9742"
              ],
            );
          } else {
            s.add([
              Color(0xFF000000),
              "05/2024",
              "HOUSSEM SELMI",
              "9874 4785 XXXX 6548"
            ]);
          }
        });
      }
    } on PlatformException catch (e) {
      print(e);
      // Navigator.of(context).pop();
    }
  }

// Build the FloatingActionButton
  Container _buildAddCardButton({
    @required Icon icon,
    @required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          print("Add a credit card");
          imagepick();
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}
