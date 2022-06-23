import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:movieday_app/models/user.dart';

Future<http.Response> valideUser(String username) async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/users/byusername?username=$username";
  var response = await http.get(Uri.parse(url));
  return response;
}

saveUsername(String username) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("usernameValue", username);
}

Future<String> getLocalUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance(); 
  String localUsername = prefs.getString("usernameValue") ?? "";
  return localUsername;
}

Future<http.Response> createUser(User user) async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/users";
  Map data = {
      'username': user.username,
      'password': user.password,
      'name': user.name,
      'lastname': user.lastname,
      'date_birth': user.datebirth
  };
  var body = json.encode(data);
  var response = await http.post(
    Uri.parse(url),
    body: body
  );
  return response;
}

Future<http.Response> updateUser(User user) async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/users";
  Map data = {
      'username': user.username,
      'password': user.password,
      'name': user.name,
      'lastname': user.lastname,
      'date_birth': user.datebirth
  };
  var body = json.encode(data);
  var response = await http.put(
    Uri.parse(url),
    body: body
  );
  return response;
}