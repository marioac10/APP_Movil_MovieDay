import 'package:flutter/material.dart';
import 'package:movieday_app/account/account.dart';
import 'package:movieday_app/account/login.dart';
import 'package:movieday_app/models/user.dart';
import 'package:movieday_app/services/account_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  @override
  void initState() { 
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    date_birthController = TextEditingController();
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Registro"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeySignup,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 25.0, right: 25, bottom: 20),
            child: Column(
              children: [
                const Text("Datos del usuario",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
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
                ElevatedButton(
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
                        var response = await createUser(user);
                        showDialogConfirmation(context,"Usuario registrado con éxito",const Login());
                      });
                    }         
                  },
                  child: const Text("Registrar", style: TextStyle(fontSize: 25, color: Colors.white)
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(230, 74, 25,1),
                    padding: const EdgeInsets.all(10),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  ),        
                )
              ]
            ),
          ),
        ),
      ),

    );
  }
}

