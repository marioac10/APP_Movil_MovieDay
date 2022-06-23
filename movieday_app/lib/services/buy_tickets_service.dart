import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieday_app/models/ticket_model.dart';

Future<http.Response> postCompra(TicketModel ticket) async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/compras";
  Map data = {
      'username' : ticket.username,
      'claveTicket': ticket.claveTiket,
      'idpelicula' : ticket.idpelicula,
      'nombrePelicula' : ticket.nombrePelicula,
      'numeroBoletos' : ticket.numBoletos,
      'fecha' : ticket.fecha,
      'listaAsientos' : ticket.listaAsientos,
      'total' : ticket.total
  };
  var body = json.encode(data);
  // print(body);
  var response = await http.post(
    Uri.parse(url),
    body: body
  );
  return response;
}

Future<List<TicketModel>> getCompras(String username) async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/compras/byusername?username=$username";
  var response = await http.get(Uri.parse(url));
  var decodeJson = await jsonDecode(response.body);
  // print(decodeJson);
  List<TicketModel> listaTicket = [];
  for (var ticket in decodeJson) {
    listaTicket.add(TicketModel.fromJson(ticket));
  } 

  return listaTicket;
}