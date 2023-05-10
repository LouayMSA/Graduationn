import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<AnimatedListState> _ListKey = GlobalKey();
  List<String> _data = [];
  String url = '';
  var data;
  String output = 'Initial Output';
  /* final Completer<GoogleMapController> _controller = Completer(); */
  static const LatLng sourceLocation =
      LatLng(29.97571558591313, 30.967522716146515);
  /*  static const LatLng destination = LatLng(29.95728913452954, 30.95702302184189); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: const Text('iRepair'),
        ),
        body: Stack(
          children: <Widget>[
            const GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: sourceLocation, zoom: 13.5),
            ),
            /*  AnimatedList(
              key: _ListKey,
              initialItemCount: _data.length,
              itemBuilder: (BuildContext context, int index, Animation animation) {
                return buildItem(_data[index], animation, index);
                },
              
            ), */
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                    height: 70, //height of button
                    width: 80,
                    child: FloatingActionButton(
                      child: const Icon(Icons.chat),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                        ;
                      },
                    ))),
          ],
        ));
  }

  /* Widget buildItem(String item, Animation animation, int index)
  {

  } */

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('iRepair ChatBot'),
          content: TextField(
            decoration: InputDecoration(
                icon: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.green,
                ),
                hintText: 'Hello!'),
          ),
          /*  actions: [
            TextButton(
              child: const Icon(
                Icons.arrow_forward_sharp,
                color: Colors.green,
              ),
              onPressed: () {},
            ),
          ], */
        ),
      );
}
