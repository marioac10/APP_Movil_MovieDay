import 'package:flutter/material.dart';
import 'package:movieday_app/models/movie_date_model.dart';
import 'package:movieday_app/models/ticket_model.dart';

class MovieDateCard extends StatelessWidget {
  const MovieDateCard({
    Key? key,
    required this.date,
    required this.isSelected,
    // required this.ticket
  }) : super(key: key);

  final MovieDate date;
  final bool isSelected;
  // final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? const Color.fromRGBO(203, 67, 53, 1) : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color.fromRGBO(203, 67, 53, 1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day} ${date.month}',
            style: TextStyle(
                color: isSelected ? Colors.white70 : const Color.fromRGBO(203, 67, 53, 1)),
          ),
          const SizedBox(height: 5),
          Text(
            date.hour,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color.fromRGBO(203, 67, 53, 1),
            ),
          ),
        ],
      ),
    );
  }
}