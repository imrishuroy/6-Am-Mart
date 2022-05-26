import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  const DisplayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      child: Column(
        children: [
          SizedBox(
              width: size.width * 0.8,
              height: 150,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset('assets/image/veggies.png',
                      fit: BoxFit.cover))),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                width: size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Dummy Text',
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                  left: 14,
                  top: -20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      child: ClipOval(
                          child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBQtnO_dGASly9kbY79BTNRZf9tbx7ngdLwQAITPtkBGk59Kxxs92RIajmuu9GWBvUbik&usqp=CAU')),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
