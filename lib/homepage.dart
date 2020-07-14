import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool ohTurn = true; // The first player is 0!

  List<String> displayEx0h = ['','','','','','','','',''];

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player O', style: myTextStyle,),
                        Text(ohScore.toString(), style: myTextStyle,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player X', style: myTextStyle,),
                        Text(exScore.toString(), style: myTextStyle,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
              child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
             itemBuilder: (BuildContext context, int index) {
               return GestureDetector(
                 onTap: () {
                   _tapped(index);
                 },
                  child: Container(
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey[700])
                   ),
                   child: Center(
                     child: Text(
                       displayEx0h[index],
                      style: TextStyle(color: Colors.white,
                       fontSize: 40),
                   ),
                 )),
               );
             }),
          ),

          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('TIC TAC TOE', style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {

    

    setState(() {
      if (ohTurn && displayEx0h[index] == '') {
        displayEx0h[index] = 'o';
        filledBoxes += 1;
      } else if(!ohTurn && displayEx0h[index] == ''){
        displayEx0h[index] = 'x';
        filledBoxes += 1;
      }

      ohTurn =! ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {

    if (displayEx0h[0] == displayEx0h[1] &&
     displayEx0h[0] == displayEx0h[2] &&
      displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }

    if (displayEx0h[3] == displayEx0h[4] &&
     displayEx0h[3] == displayEx0h[5] &&
      displayEx0h[3] != '') {
      _showWinDialog(displayEx0h[3]);
    }

    if (displayEx0h[6] == displayEx0h[7] &&
     displayEx0h[6] == displayEx0h[8] &&
      displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }

    if (displayEx0h[0] == displayEx0h[3] &&
     displayEx0h[0] == displayEx0h[6] &&
      displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }

    if (displayEx0h[1] == displayEx0h[4] &&
     displayEx0h[1] == displayEx0h[7] &&
      displayEx0h[1] != '') {
      _showWinDialog(displayEx0h[1]);
    }

    if (displayEx0h[2] == displayEx0h[5] &&
     displayEx0h[2] == displayEx0h[8] &&
      displayEx0h[2] != '') {
      _showWinDialog(displayEx0h[2]);
    }

    if (displayEx0h[6] == displayEx0h[4] &&
     displayEx0h[6] == displayEx0h[2] &&
      displayEx0h[6] != '') {
      _showWinDialog(displayEx0h[6]);
    }

    if (displayEx0h[0] == displayEx0h[4] &&
     displayEx0h[0] == displayEx0h[8] &&
      displayEx0h[0] != '') {
      _showWinDialog(displayEx0h[0]);
    }

    else if (filledBoxes == 9) {
      _showDrawDialog();
    }

  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Draw'),
          actions: <Widget>[
            FlatButton(
              child: Text('Play Again!'),
              onPressed: (){
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner IS: ' + winner),
          actions: <Widget>[
            FlatButton(
              child: Text('Play Again!'),
              onPressed: (){
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
    if (winner == 'o') {
      ohScore += 1;
    } else if(winner == 'x'){
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i=0; i<9; i++) {
      displayEx0h[i] = '';
    }
    });

    filledBoxes = 0;
  }
}