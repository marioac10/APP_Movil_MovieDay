import 'package:flutter/material.dart';
import 'package:movieday_app/models/movie_date_model.dart';
import 'package:movieday_app/models/ticket_model.dart';
import 'movie_date_card.dart';

class MovieDates extends StatefulWidget {
  const MovieDates({
    Key? key,
    required this.dates,
    required this.ticket
  }) : super(key: key);

  final List<MovieDate> dates;
  final TicketModel ticket;

  @override
  State<MovieDates> createState() => _MovieDatesState();
}

class _MovieDatesState extends State<MovieDates> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    widget.ticket.fecha = widget.dates[_selectedIndex];
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: widget.dates.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              widget.ticket.fecha = widget.dates[_selectedIndex];
            });
          },
          child: MovieDateCard(
            date: widget.dates[index],
            isSelected: index == _selectedIndex,
            // ticket: widget.ticket
          ),
        );
      },
    );
  }
}