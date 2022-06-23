// import 'package:flutter/material.dart';

// class PasswordField extends StatefulWidget {
//   const PasswordField({Key? key}) : super(key: key);

//   @override
//   _PasswordFieldState createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   final textFieldFocusNode = FocusNode();
//   bool _obscured = false;

//   void _toggleObscured() {
//     setState(() {
//       _obscured = !_obscured;
//       if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
//       textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       keyboardType: TextInputType.visiblePassword,
//       obscureText: _obscured,
//       focusNode: textFieldFocusNode,
//       decoration: InputDecoration(
//         floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
//         labelText: "Password",
//         filled: true, // Needed for adding a fill color
//         fillColor: Colors.grey.shade800, 
//         isDense: true,  // Reduces height a bit
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,              // No border
//           borderRadius: BorderRadius.circular(12),  // Apply corner radius
//         ),
//         prefixIcon: Icon(Icons.lock_rounded, size: 24),
//         suffixIcon: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
//           child: GestureDetector(
//             onTap: _toggleObscured,
//             child: Icon(
//               _obscured
//                   ? Icons.visibility_rounded
//                   : Icons.visibility_off_rounded,
//               size: 24,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';


class Ejmplo extends StatefulWidget {
  const Ejmplo({ Key? key }) : super(key: key);

  @override
  State<Ejmplo> createState() => _FormFieldSampleState();
}
class _FormFieldSampleState extends State<Ejmplo> {

  // Initially password is obscure
  bool _obscureText = true;

  String _password = '';

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Password',
                  icon: const Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Icon(Icons.lock))),
              validator: (val) => val!.length < 6 ? 'Password too short.' : null,
              onSaved: (val) => _password = val.toString(),
              obscureText: _obscureText,
            ),
            new FlatButton(
                onPressed: _toggle,
                child: new Text(_obscureText ? "Show" : "Hide"))
          ],
        ),
      ),
    );
  }
}