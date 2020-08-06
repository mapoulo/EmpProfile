import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/home/details.dart';

class BottomPart extends StatefulWidget {
  @override
  _BottomPartState createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart> {
  @override
  Widget build(BuildContext context) {
    final flowers = Provider.of<List<Flowers>>(context) ?? [];

    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 174, 179, 175),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Flowers",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: flowers.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Details(flower: flowers[index]),
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5, bottom: 10),
                            height: MediaQuery.of(context).size.height,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Hero(
                                tag: "image" + index.toString(),
                                child: Image.network(
                                  flowers[index].flowerName,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 170.0,
                          left: 105.0,
                          child: Container(
                            height: 20,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFF0E3311).withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                )),
                            child: Center(
                              child: Text(
                                "View",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    ));
  }
}
