import 'package:flutter/material.dart';
import 'package:hexnavigationbottom/HexNavigationButton/HexNavigationBottom.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String text = "";
  HexNavigationBottomController controller = new HexNavigationBottomController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(text),
                        RaisedButton(onPressed: (){
                          controller.changeItemSelected(3);
                        },
                          child: Text("Move to last"),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    )
                ),
              ),
            ),
            HexNavigationBottom(
              iconMain: Icon(Icons.search,color: Colors.white,),
              itens: [
                Icon(Icons.home),
                Icon(Icons.camera),
                Icon(Icons.chat_bubble),
                Icon(Icons.person),
              ],
              onTapMain: (){
                setState(() {
                  text = "onTapMain";
                });
              },
              itemSelectedListern: (position){
                position = position;
                setState(() {
                  text = "position: $position";
                });
              },
              controller: controller,
            )
          ],
        ),

      ),// This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}
