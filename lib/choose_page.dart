import 'package:flutter/material.dart';
import 'package:memory_game/game_page/game_level_1.dart';
import 'package:memory_game/game_page/game_level_2.dart';
import 'package:memory_game/game_page/game_level_3.dart';

class ChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("レベルを選択してください"),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                minWidth: 150,
                height: 100,
                padding: const EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.grey[300],
                  child: const Text('レベル1'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GameLevel1();
                    }));
                  },
                  highlightColor: Colors.redAccent,
                  onHighlightChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                minWidth: 150,
                height: 100,
                padding: const EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.grey[300],
                  child: const Text('レベル2'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GameLevel2();
                    }));
                  },
                  highlightColor: Colors.blueAccent,
                  onHighlightChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                minWidth: 150,
                height: 100,
                padding: const EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.grey[300],
                  child: const Text('レベル3'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GameLevel3();
                    }));
                  },
                  highlightColor: Colors.blueAccent,
                  onHighlightChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
