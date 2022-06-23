import 'package:movieday_app/models/movie_date_model.dart';

class TicketModel{
  String? username;
  String? claveTiket;
  String? idpelicula;
  String? nombrePelicula;
  String? numBoletos;
  MovieDate? fecha;
  List<SelectedSeat> listaAsientos;
  String? total;
  TicketModel({
    this.username,
    this.claveTiket,
    this.idpelicula,
    this.nombrePelicula,
    this.numBoletos,
    this.fecha,
    required this.listaAsientos,
    this.total
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
      username: json["user"] == null ? '' : json["user"],
      claveTiket: json["claveTicket"] == null ? '' : json["claveTicket"],
      idpelicula: json["idpelicula"] == null ? '' : json["idpelicula"],
      nombrePelicula: json["nombrePelicula"] == null ? '' : json["nombrePelicula"],
      numBoletos: json["numeroBoletos"] == null ? '' : json["numeroBoletos"],
      fecha: json["fecha"] == null ? null : MovieDate.fromJson(json["fecha"]),
      listaAsientos: json["listaAsientos"] == null ? [] : List<SelectedSeat>.from(json["listaAsientos"].map((x) => SelectedSeat.fromJson(x))),
      total: json["total"] == null ? '' : json["total"]
    );

    Map<String, dynamic> toJson() => {
        "user": username == null ? null : username,
        "claveTicket" : claveTiket == null ? null : claveTiket,
        "idpelicula" : idpelicula == null ? null : idpelicula,
        "nombrePelicula" : nombrePelicula == null ? null : nombrePelicula,
        "numeroBoletos" : numBoletos == null ? null : numBoletos,
        "fecha" : fecha == null ? null : fecha?.toJson(),
        "listaAsientos" : listaAsientos == null ? null : List<dynamic>.from(listaAsientos.map((x) => x.toJson())),
        "total" : total == null ? null : total
    };
  
}


class SelectedSeat{
  String seccion;
  String numAsiento;
  SelectedSeat({
    required this.seccion, 
    required this.numAsiento
  });

  factory SelectedSeat.fromJson(Map<String, dynamic> json) => SelectedSeat(
      seccion: json["seccion"] == null ? '' : json["seccion"],
      numAsiento: json["numAsiento"] == null ? '' : json["numAsiento"]
    );

    Map<String, dynamic> toJson() => {
        "seccion": seccion == null ? '' : seccion,
        "numAsiento" : numAsiento == null ? '' : numAsiento
    };




}