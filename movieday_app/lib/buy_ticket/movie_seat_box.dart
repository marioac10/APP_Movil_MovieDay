import 'package:flutter/material.dart';
import 'package:movieday_app/models/movie_date_model.dart';
import 'package:movieday_app/models/ticket_model.dart';

class MovieSeatBox extends StatefulWidget {
  const MovieSeatBox({
    Key? key,
    required this.seat,
    required this.ticket
  }) : super(key: key);

  final Seat seat;
  final TicketModel ticket;

  @override
  State<MovieSeatBox> createState() => _SeatBoxState();
}

class _SeatBoxState extends State<MovieSeatBox> {
  @override
  void initState() {
    widget.seat.isSelected=false;
    super.initState();
  }
  @override
  void dispose() {
    // widget.seat.isSelected = false;
    super.dispose();
  }
  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  @override
  Widget build(BuildContext context) {
    final color = widget.seat.isHidden
        ? Colors.white
        : widget.seat.isOcuppied
            ? Colors.black
            : widget.seat.isSelected
                ? const Color.fromRGBO(203, 67, 53, 1)
                : Colors.grey.shade200;
    return GestureDetector(
      onTap: () {
        //ticket 
        // print(widget.seat.seccion.toString());
        setState(() {
          widget.seat.isSelected = !widget.seat.isSelected;
          if(widget.seat.isSelected == false){
            // print("Entro");
            widget.ticket.listaAsientos.removeWhere((e) => e.seccion == widget.seat.seccion && e.numAsiento == widget.seat.numAsiento);
          }else{
            // print(widget.seat.seccion);
            // print(widget.seat.numAsiento);
            SelectedSeat seat = SelectedSeat(seccion: widget.seat.seccion, numAsiento: widget.seat.numAsiento.toString());
            // print(seat.numAsiento);
            widget.ticket.listaAsientos.add(seat);
            // print(widget.ticket.listaAsientos.length.toString());
          }
          // widget.ticket;
          // print(widget.seat.seccion);
          // print(widget.seat.numAsiento);
          
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
    );
  }
}
