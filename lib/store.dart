import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Datadisplay(),
      ),
    );
  }
}

class Datadisplay extends StatefulWidget {
  const Datadisplay({Key? key}) : super(key: key);

  @override
  _DatadisplayState createState() => _DatadisplayState();
}

class _DatadisplayState extends State<Datadisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Text('loading faqs');
          else {
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                                height: 500,
                                width: 400,
                                child: Image(
                                    image:
                                        AssetImage('images/Rectangle 23.png'))),
                            Text(
                              '${snapshot.data!.docs[0]['prod_name']}\nFull Rim Round,Cat Eyed Anti-glare frame\n(48mm)',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(children: [
                                Text(
                                  '₹${snapshot.data!.docs[0]['price']} ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '₹9000 ',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '₹${snapshot.data!.docs[0]['offer']}% off ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                RaisedButton(
                                  padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Store()),
                                  ),
                                  child: Text('Add to cart',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500)),
                                  color: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Store()),
                                  ),
                                  child: Text('Buy Now',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500)),
                                  color: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
