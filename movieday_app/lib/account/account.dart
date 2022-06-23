import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieday_app/home/all_movies.dart';
import 'package:movieday_app/main.dart';
import 'package:movieday_app/models/user.dart';
import 'package:movieday_app/services/account_service.dart';

class Account extends StatefulWidget {
  const Account({ Key? key }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  //FormKey
  final _formKeySignup =  GlobalKey<FormState>();
  //Text Controllers
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController lastnameController;
  late TextEditingController date_birthController;
  DateTime selectedDate = DateTime.now();
  //Password
  bool _obscured = true;
  //User data
  String localUsername = '';
  User user = User();

  @override
  void initState() { 
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    date_birthController = TextEditingController();
    Future.delayed(Duration.zero,()async{
      localUsername = await getLocalUsername();
      user = await getUser(localUsername);
      setState(() {
        user;
      });
      cargarUserData(user);
    });
    super.initState();
  }

  Future<User> getUser(String username)async{
    var response = await valideUser(username);
    User user = User();
    if(response.statusCode ==200){
      var decodeJson = jsonDecode(response.body);
      user = User.fromJson(decodeJson);
    }
    return user;
  }

  void cargarUserData(User user){
    usernameController.text = user.username.toString();
    passwordController.text = user.password.toString();
    nameController.text = user.name.toString();
    lastnameController.text = user.lastname.toString();
    date_birthController.text = user.datebirth.toString();
  }
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    lastnameController.dispose();
    date_birthController.dispose();
    super.dispose();
  }



  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      // if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      // textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  _selectDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: DateTime(2023)
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        var date = "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        date_birthController.text = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return user.username != null ? Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKeySignup,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 25.0, right: 25, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text("Datos del usuario",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text("Usuario", style: TextStyle(fontSize: 18),),
                ),
                TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Este campo es obligatorio";
                    }
                  },
                  style: TextStyle(fontSize: size.width * 0.05),
                  decoration: const InputDecoration( 
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
                    contentPadding: EdgeInsets.all(15)
                  ),
                ),
                const SizedBox(height: 20,),
                 const Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text("Contraseña", style: TextStyle(fontSize: 18),),
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Este campo es obligatorio";
                    }
                  },
                  obscureText: _obscured,
                  style: TextStyle(fontSize: size.width * 0.05),
                  decoration: InputDecoration( 
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
                    prefixIcon: const  Icon(Icons.lock, size: 30),
                    suffixIcon: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                        (_obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded), size: 30,
                      )
                    ),
                    contentPadding: EdgeInsets.all(15)
                  ),
                ),
                const SizedBox(height: 20,),
                 const Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text("Nombre", style: TextStyle(fontSize: 18),),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Este campo es obligatorio";
                    }
                  },
                  style: TextStyle(fontSize: size.width * 0.05),
                  decoration: const InputDecoration( 
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
                    hintText: "Nombre",
                    prefixIcon: Icon(Icons.text_format, size: 30),
                    contentPadding: EdgeInsets.all(15)
                  ),
                ),
                const SizedBox(height: 20),
                 const Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text("Apellido", style: TextStyle(fontSize: 18),),
                ),
                TextFormField(
                  controller: lastnameController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Este campo es obligatorio";
                    }
                  },
                  style: TextStyle(fontSize: size.width * 0.05),
                  decoration: const InputDecoration( 
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
                    hintText: "Apellido",
                    prefixIcon: Icon(Icons.text_format, size: 30),
                    contentPadding: EdgeInsets.all(15)
                  ),
                ),
                const SizedBox(height: 20,),
                 const Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text("Fecha de nacimiento", style: TextStyle(fontSize: 18),),
                ),
                GestureDetector(
                  onTap:() => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: date_birthController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Este campo es obligatorio";
                        }
                      },
                      style: TextStyle(fontSize: size.width * 0.05),
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration( 
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
                        hintText: "Fecha de nacimiento",
                        prefixIcon: Icon(Icons.calendar_today, size: 30),
                        contentPadding: EdgeInsets.all(15)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKeySignup.currentState?.validate() ?? false){
                        Future.delayed(Duration.zero,() async{
                          String username = usernameController.text;
                          String password = passwordController.text;
                          String name = nameController.text;
                          String lastname = lastnameController.text;
                          String date_birth = date_birthController.text;
                          print(username+" "+" "+password+" "+" "+name+" "+lastname+" "+date_birth);
                          User user = User(username: username,password: password,name: name, lastname: lastname,datebirth: date_birth);
                          var response = await updateUser(user);
                          showDialogConfirmation(context, "Sus datos se han actualizado correctamente", const MyHomePage());
                          // if(response.statusCode == 200){
                          //   print("Se ha registrado un usuario");
                          // }
                        });
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                      }
                                    
                    },
                    child: const Text("Guardar", style: TextStyle(fontSize: 25, color: Colors.white)
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(230, 74, 25,1),
                      padding: const EdgeInsets.all(10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    ),        
                  ),
                )
              ]
            ),
          ),
        ),
      ),

    ) : Center(child: CircularProgressIndicator(),);
  }
}

showDialogConfirmation(BuildContext context, String message,Widget view) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> view));
              }, 
              child: const Text("OK")
            )
          ],
        );
      }
    );
  }