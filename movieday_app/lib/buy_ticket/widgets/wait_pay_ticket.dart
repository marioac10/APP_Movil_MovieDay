import 'package:flutter/material.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              backgroundColor: Colors.black87,
              content: LoadingIndicator(
                  text: text
              ),
            )
        );
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}


class LoadingIndicator extends StatelessWidget{
  LoadingIndicator({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(),
              _getText(displayedText)
            ]
        )
    );
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: const CircularProgressIndicator(
                strokeWidth: 3
            ),
            width: 32,
            height: 32
        ),
        padding: const EdgeInsets.only(bottom: 16)
    );
  }

  Widget _getHeading() {
    return
      const Padding(
          child: Text(
            'Por favor espere...',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 4)
      );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 14
      ),
      textAlign: TextAlign.center,
    );
  }
}