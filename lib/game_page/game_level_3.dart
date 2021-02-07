import 'package:flutter/material.dart';
import 'package:memory_game/choose_page.dart';
import 'package:memory_game/data/data3.dart';

class GameLevel3 extends StatefulWidget {
  @override
  _Gamelevel3 createState() => _Gamelevel3();
}

class _Gamelevel3 extends State<GameLevel3> {
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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            points != 2000
                ? Column(
                    children: [
                      Text(
                        '$points/2000',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Text('Points'),
                      Text(
                        'ターン数:$challenge',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
            points != 2000
                ? Column(
                    children: [
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 55.0),
                        children: List.generate(visiblePairs.length, (index) {
                          return Tile(
                            imageAssetPath:
                                visiblePairs[index].getImageAssetPath(),
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  challenge = 0;

                                  points = 0;

                                  return GameLevel3();
                                }));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            child: RaisedButton(
                              child: Text('戻る'),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  challenge = 0;

                                  points = 0;

                                  return ChoosePage();
                                }));
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Container(
                    child: (() {
                      if (challenge == 20) {
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    challenge = 0;

                                    points = 0;

                                    return ChoosePage();
                                  }));
                                },
                                color: Colors.green,
                                textColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text("君は天才だ"),
                            ),
                          ],
                        );
                      } else if (challenge <= 25) {
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    challenge = 0;

                                    points = 0;

                                    return ChoosePage();
                                  }));
                                },
                                color: Colors.green,
                                textColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text("なかなかの記憶力！"),
                            ),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    challenge = 0;

                                    points = 0;

                                    return ChoosePage();
                                  }));
                                },
                                color: Colors.green,
                                textColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text("次は頑張ろう！"),
                            ),
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

  _Gamelevel3 parent;

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
                challenge++;

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
              Future.delayed(const Duration(seconds: 1), () {
                challenge++;
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
          child: pairs[widget.tileIndex].getImageAssetPath() != ""
              ? Image.asset(pairs[widget.tileIndex].getIsSelected()
                  ? pairs[widget.tileIndex].getImageAssetPath()
                  : widget.imageAssetPath)
              : Image.asset("assets/correct.png")),
    );
  }
}
