import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/choose_page.dart';
import 'package:memory_game/data/data.dart';

class GameLevel1 extends StatefulWidget {
  @override
  _GameLevel1 createState() => _GameLevel1();
}

class _GameLevel1 extends State<GameLevel1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pairs = getPairs();
    pairs.shuffle();

    visiblePairs = pairs;
    selected = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        visiblePairs = getQuestions();
        selected = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            points != 800 ? Column(
              children: [
                Text(
                  '$points/800',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Text('Points'),
                Text(
                  'ターン数:$challenge',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ) : Container(),
            SizedBox(
              height: 20,
            ),
            points != 800 ? Column(
              children: [
                GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 0.0, maxCrossAxisExtent: 100),
                  children: List.generate(visiblePairs.length, (index) {
                    return Tile(
                      imageAssetPath: visiblePairs[index].getImageAssetPath(),
                      parent: this,
                      tileIndex: index,
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: RaisedButton(
                        child: Text('リセットする'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                  challenge = 0;
                                  points = 0;
                                return GameLevel1();
                              }
                          ));
                        },
                      ),
                    ),
                    SizedBox(width: 30,),
                    Container(
                      child: RaisedButton(
                        child: Text('戻る'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                challenge = 0;
                                points = 0;
                                return ChoosePage();
                              }
                          ));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ) : Container(
              child:
              (() {
                if (challenge == 8) {
                  challenge = 0;
                  points = 0;

                  return Column(
                    children: [
                      Container(
                        child: RaisedButton.icon(
                          icon: const Icon(
                            Icons.tag_faces,
                            color: Colors.white,
                          ),
                          label: const Text('戻る'),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  challenge = 0;
                                  points = 0;
                                  return ChoosePage();
                                }
                            ));
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(child:Text("君は天才だ"),),
                    ],
                  );
                } else {
                  challenge = 0;
                  points = 0;

                  return Column(
                    children: [
                      Container(
                        child: RaisedButton.icon(
                          icon: const Icon(
                            Icons.tag_faces,
                            color: Colors.white,
                          ),
                          label: const Text('戻る'),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  challenge = 0;
                                  points = 0;
                                  return ChoosePage();
                                }
                            ));
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(child:Text("次は頑張ろう！"),),

                    ],
                  );
                }
              })(),
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  String imageAssetPath;
  int tileIndex;

  _GameLevel1 parent;

  Tile({
    this.imageAssetPath,
    this.parent,
    this.tileIndex,
  });

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          if (selectedImageAssetPath != "") {
            if (selectedImageAssetPath ==
                pairs[widget.tileIndex].getImageAssetPath()) {
              // correct
              print('正解!');
              selected = true;

              Future.delayed(const Duration(seconds: 1), () {
                points = points + 100;
                challenge ++;

                setState(() {});
                selected = false;
                widget.parent.setState(() {
                  pairs[widget.tileIndex].setImageAssetPath("");
                  pairs[selectedTileIndex].setImageAssetPath("");
                });
                selectedImageAssetPath = "";
              });
            } else {
              // wrong choice
              print('不正解!');

              selected = true;
              Future.delayed(const Duration(seconds: 2),(){
                challenge ++;
                selected = false;
                widget.parent.setState(() {
                  pairs[widget.tileIndex].setIsSelected(false);
                  pairs[selectedTileIndex].setIsSelected(false);
                });

                selectedImageAssetPath = "";
              });
            }
          } else {
            selectedTileIndex = widget.tileIndex;
            selectedImageAssetPath =
                pairs[widget.tileIndex].getImageAssetPath();
          }
          setState(() {
            pairs[widget.tileIndex].setIsSelected(true);
          });
          print("Clicked");
        }
      },
      child: Container(
          margin: EdgeInsets.all(5),
          child: pairs[widget.tileIndex].getImageAssetPath() != "" ? Image.asset(
              pairs[widget.tileIndex].getIsSelected() ? pairs[widget.tileIndex]
                  .getImageAssetPath() : widget.imageAssetPath) : Image.asset("assets/correct.png")
      ),
    );
  }
}