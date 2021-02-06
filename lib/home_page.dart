import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:memory_game/choose_page.dart';


class MyHomePage extends StatefulWidget {
  String level;

  MyHomePage({Key key, this.title, this.level,}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Image.asset("assets/luffy.png"),
                  ),
                  Container(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1.0,
                          colors: <Color>[Colors.red, Colors.yellow],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Text(
                        "ONE PIECE 神経衰弱ゲーム",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: ((MediaQuery.of(context).size.width) / 2) - 10,
                    height: 50,
                    child: FlatButton(
                      focusColor: Colors.red,
                      highlightColor: Colors.blue,
                      hoverColor: Colors.lightBlue[100],
                      color: Colors.indigo,
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.white),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return RadialGradient(
                            center: Alignment.topLeft,
                            radius: 1.0,
                            colors: <Color>[Colors.red, Colors.yellowAccent],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: Text(
                          "ゲームを開始する",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return ChoosePage();
                            }
                        ));
                      },
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),

    );
  }
}