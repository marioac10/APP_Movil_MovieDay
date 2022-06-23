import 'package:flutter/material.dart';
import 'package:movieday_app/models/movie_date_model.dart';
import 'package:movieday_app/models/section_seat_model.dart';
import 'package:movieday_app/models/ticket_model.dart';

import 'movie_seat_box.dart';

class MovieSeatSection extends StatelessWidget {
  const MovieSeatSection({
    Key? key,
    required this.seats,
    this.isFront = false,
    required this.ticket
  }) : super(key: key);

  final List<Seat> seats;
  // final Section seats;
  final bool isFront;
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isFront ? 16 : 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (_, index) {
          final seat = seats[index];
          // final seat = seats.listaA[index];
          return MovieSeatBox(seat: seat, ticket: ticket);
        },
      ),
    );
  }
}
