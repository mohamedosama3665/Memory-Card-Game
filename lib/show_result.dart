import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

class ShowResult extends StatelessWidget {
  final String time;
  const ShowResult({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You win in ${time}s Congratulations', style: GoogleFonts.acme(fontSize: 60, ), textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Game()));
              },
              child: Text('Play Again', style: GoogleFonts.acme(fontSize: 18, color: Colors.white),),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
