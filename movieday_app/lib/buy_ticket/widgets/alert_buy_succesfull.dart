import 'package:flutter/material.dart';
import 'package:movieday_app/main.dart';

showDialogCorrecto(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("🔥Compra exitosa🔥", textAlign: TextAlign.center,),
          content: SizedBox(
            height: 40,
            child: Center(
              child: Icon(Icons.add_task, color: Colors.green[400],size: 80,)
              )
            ),
          actions: [
            TextButton(
                onPressed:() { 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
                }, 
                child: const Text("OK")
              )
          ],

        );

      }
    );
  }