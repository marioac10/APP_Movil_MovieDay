import 'package:flutter/material.dart';

import 'package:movieday_app/models/movie_date_model.dart';
import 'package:movieday_app/models/section_seat_model.dart';
import 'package:movieday_app/models/ticket_model.dart';

import 'movie_seat_section.dart';

class MovieSeats extends StatelessWidget {
  const MovieSeats({
    Key? key,
    required this.seats,
    required this.ticket
  }) : super(key: key);

  // final List<List<Seat>> seats;
  final List<Section> seats;
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < 3; i++)
              MovieSeatSection(
                seats: seats[i].listaA,
                isFront: true,
                ticket: ticket
              ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            for (int i = 3; i < 6; i++)
              MovieSeatSection(
                seats: seats[i].listaA,
                ticket: ticket
              ),
          ],
        ),
      ],
    );
  }
}
