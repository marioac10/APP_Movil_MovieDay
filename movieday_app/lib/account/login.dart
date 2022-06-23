import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:movieday_app/account/ejemplo.dart';
import 'package:movieday_app/account/sign_up.dart';
import 'package:movieday_app/main.dart';
import 'package:movieday_app/services/account_service.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Form key
  final _fomrKeyLogin = GlobalKey<FormState>();
  //Text Controllers
  late TextEditingController txtUserController;
  late TextEditingController txtPasswordController;
  String? errorUser;
  bool validar = false;
  bool _obscured = true;
  bool _validando = false;

  Future<void> loginUser(String username, String password)async{
    var response = await valideUser(username);
    if(response.statusCode == 200){
      String pass = json.decode(response.body)['password'];
      if(password == pass){
        setState(() {
          validar = true;
        });
      }else{
        setState(() {
          errorUser = "Usuario y/o password incorrecto";
        });
      }
    }else{
      setState(() {
        errorUser = "Usuario y/o password incorrecto";
      });

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    txtUserController = TextEditingController();
    txtPasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    txtUserController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  void _toggleObscured(){
    setState(() {
      _obscured = !_obscured;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(203, 67, 53, 1),
        // color: Color.fromRGBO(136,14,79,1),
        // image: DecorationImage(
        //   image: AssetImage('assets/background.jpeg'),
        //   fit: BoxFit.cover
        // )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo_transparent.png', width: size.width*0.8),
              ],
            ),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(top:5,left: 30,right: 30,bottom: 30 ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(241, 148, 138, 1),//Orange
                  // color: Color.fromRGBO(136,14,79, 0.8),//Vino
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0,5)
                    )
                  ]
                ),
                child: Form(
                  key: _fomrKeyLogin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        child: Text(
                          "INICIAR SESIÓN",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: size.width*0.06),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                        child: TextFormField(
                          controller: txtUserController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }else{
                              return null;
                            }
                          },
                          style: TextStyle(fontSize: size.width * 0.05),
                          decoration: const InputDecoration( 
                            errorStyle: TextStyle(
                              fontSize: 17
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none
                              )
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(241, 241, 241, 1),
                            isDense: true,
                            hintText: "Usuario",
                            prefixIcon: Icon(Icons.account_circle_outlined, size: 30),
                            contentPadding: EdgeInsets.all(20)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                        child: TextFormField(
                          controller: txtPasswordController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }else{
                              return null;
                            }
                          },
                          obscureText: _obscured,
                          style: TextStyle(fontSize: size.width * 0.05),
                          decoration: InputDecoration( 
                            errorStyle: const TextStyle(
                              fontSize: 17,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none
                              )
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(241, 241, 241, 1),
                            isDense: true,
                            hintText: "Contraseña",
                            prefixIcon: const Icon(Icons.password_rounded, size: 30,),
                            suffixIcon: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded, size: 30,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(20)
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        height: 50,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          overflow: Overflow.visible,
                          children: [
                            Positioned(
                              bottom: -20,
                              child: SizedBox(
                                width: size.width*0.4,
                                child: ElevatedButton(
                                  onPressed: (){
                                    if(_fomrKeyLogin.currentState?.validate() ?? false){
                                      Future.delayed(Duration.zero,()async{
                                        setState(() {
                                          _validando = !_validando;
                                        });
                                        String user = txtUserController.text;
                                        String pass= txtPasswordController.text;
                                        await loginUser(user,pass);
                                        if (validar != false) {
                                          await saveUsername(user);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const MyHomePage()));
                                        } else {
                                          setState(() {
                                            _validando = !_validando;
                                          });
                                          final snackBar = SnackBar(
                                            backgroundColor: Color.fromRGBO(136, 14, 79, 1),
                                            elevation: 15.0,
                                            content: Text(errorUser.toString(),style: const TextStyle(fontSize: 18),),
                                            duration: const Duration(seconds: 4),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      });
                                    }
                                    // Navigator.push(
                                    // context,
                                    // MaterialPageRoute(builder: (context)=>const MyHomePage())
                                    // );
                                  },
                                  child: const Text(
                                    "Validar",
                                    style: TextStyle(fontSize: 25, color: Colors.white)
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromRGBO(230, 74, 25,1),
                                    padding: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                  ),
                              ),
                              ),
                            ),
                        
                        ],),
                      ),
                    ],
                  ),
                ),
              ),
            )
            ,SizedBox(height: 8,),
            Container(
              child: Center(child: Text.rich(TextSpan(
                text: "¿No tiene una cuenta? ",
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "Registrarse",
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                      }
                  )
                ]
              )),)
            ),
            const SizedBox(height: 7,),
            Center(
              child: _validando ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text(""),
            )
          ],
        ),
      ),
    );
  }
}


Widget _circulasProgress(){
  return Center(
    child: CircularProgressIndicator(),
  );
}
