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
    flowers.forEach((element) {
      print(element.flowerName+" My flower name");
     });
    
    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 225, 225, 231),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Details(),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5),
                        height: MediaQuery.of(context).size.height,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: "image",
                                child: Image.network(flowers[index].flowerName),
                              ),
                            ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    )
    );
  }
}
