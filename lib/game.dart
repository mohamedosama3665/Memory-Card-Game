import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_card_game/show_result.dart';

int level = 1;

class Game extends StatefulWidget {
  final int size;
  const Game({Key? key, this.size = 12}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int time = 0;
  late Timer timer;
  bool flip = false;
  int previousIndex = -1;
  List<bool> cardFlips = [];
  List<String> data = [];
  List<GlobalKey<FlipCardState>> cardStateKeys = [];

  startTimer(){
    cardFlips.every((t) => t=false);
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
       time+=1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < widget.size; i++){
      cardStateKeys.add(GlobalKey());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    startTimer();
    data.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards Memory Game', style: GoogleFonts.acme(fontSize: 24, letterSpacing: 3, wordSpacing: -2),),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: MediaQuery.of(context).size.height*0.05),
        child: Column(
          children: [
            Text("Time:  ${time}s", style: GoogleFonts.acme(fontSize: 60, fontWeight: FontWeight.w200),),
            SizedBox(height: 10,),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) => FlipCard(
                flipOnTouch: cardFlips[index],
                key: cardStateKeys[index],
                onFlip: (){
                  if(!flip){
                    flip = true;
                    previousIndex = index;
                  }
                  else{
                    flip = false;
                    if(previousIndex != index){
                      if(data[previousIndex] != data[index]){
                        cardStateKeys[previousIndex].currentState!.toggleCard();
                        previousIndex = index;
                      }
                      else {
                        cardFlips[previousIndex] = false;
                        cardFlips[index] = false;
                        if(cardFlips.every((t) => t == false)){
                         // print("Won");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowResult(time: time.toString(),)));
                        }
                      }
                    }
                  }
                },
                direction: FlipDirection.HORIZONTAL,
                front: Container(
                  margin: EdgeInsets.all(4),
                  color: Colors.deepOrangeAccent[100],
                ),
                back: Container(
                  margin: EdgeInsets.all(4),
                  color: Colors.blueGrey[100],
                  child: Center(
                    child: Text("${data[index]}", style: GoogleFonts.acme(fontSize: 68),),
                  ),
                ),
              ),
              itemCount: data.length,
            ),
          ],
        ),
      ),
    );
  }
}
