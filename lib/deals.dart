import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Deals extends StatefulWidget {
  const Deals({Key? key}) : super(key: key);

  @override
  State<Deals> createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Melo Milk Base'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              children: [
                TableRow(children: [
                  Text(
                    "OrderDate",
                    textScaleFactor: 1.5,
                  ),
                  Text("Litres", textScaleFactor: 1.5),
                  Text("Phone Number", textScaleFactor: 1.5),
                ]),
              ],
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('deals')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                      // ignore: unnecessary_new
                        return new ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            //check whether event is on going or not
                            // print(document['date'][0]);
                            return buildTableRow(document['date'][0],
                                document['litres'], document['phone_number']);
                          }).toList(),
                        );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTableRow(String OrderDate, String Litres, String PhoneNumber) {
    // print(OrderDate);
    // print(Litres);
    // print(PhoneNumber);
    return Row(
      children: [
        Text(
          OrderDate,
          textScaleFactor: 1.5,
        ),
        Spacer(),
        Text(Litres, textScaleFactor: 1.5),
        Spacer(),
        Text(PhoneNumber, textScaleFactor: 1.5),
      ],
    );
  }
}
