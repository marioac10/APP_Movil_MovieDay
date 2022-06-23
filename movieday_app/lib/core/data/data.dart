import 'package:flutter/material.dart';
import 'package:movieday_app/models/movie_date_model.dart';
import 'package:movieday_app/models/section_seat_model.dart';

final section1 = List.generate(
  16,
  (index) => Seat(
    seccion: "A",
    isHidden: [0, 1, 4].contains(index),
    isOcuppied: [].contains(index),
    numAsiento: index
  ),
);

final section2 = List.generate(
  16,
  (index) => Seat(
    seccion: "B",
    isHidden: [4, 5, 6, 7].contains(index),
    isOcuppied: [12, 13].contains(index),
    numAsiento: index
  ),
);

final section3 = List.generate(
  16,
  (index) => Seat(
    seccion: "C",
    isHidden: [2, 3, 7].contains(index),
    isOcuppied: [13, 14, 15].contains(index),
    numAsiento: index
  ),
);

final section4 = List.generate(
  20,
  (index) => Seat(
    seccion: "D",
    isHidden: [].contains(index),
    isOcuppied: [1, 2, 3].contains(index),
    numAsiento: index
  ),
);

final section5 = List.generate(
  20,
  (index) => Seat(
    seccion: "E",
    isHidden: [].contains(index),
    isOcuppied: [].contains(index),
    numAsiento: index
  ),
);

final section6 = List.generate(
  20,
  (index) => Seat(
    seccion: "F",
    isHidden: [].contains(index),
    isOcuppied: [14].contains(index),
    numAsiento: index
  ),
);

final seatss = [
  section1,
  section2,
  section3,
  section4,
  section5,
  section6,
];

final section7 = Section(
  "A", 
  section1
); 
final section8 = Section(
  "B", 
  section2
); 
final section9 = Section(
  "C", 
  section3
); 
final section10 = Section(
  "D", 
  section4
); 
final section11 = Section(
  "E", 
  section5
);

final section12 = Section(
  "F", 
  section6
); 

final seats = [
  section7,
  section8,
  section9,
  section10,
  section11,
  section12
];

const seatTypes = [
  SeatType(name: 'Available', color: Colors.grey),
  SeatType(name: 'Booked', color: Colors.black),
  SeatType(name: 'Selection', color: Color.fromRGBO(203, 67, 53, 1)),
];

const dates = [
  MovieDate(day: '16', month: 'JUL 2022', hour: '6:00PM'),
  MovieDate(day: '16', month: 'JUL 2022', hour: '8:00PM'),
  MovieDate(day: '16', month: 'JUL 2022', hour: '9:00PM'),
  MovieDate(day: '16', month: 'JUL 2022', hour: '10:00PM'),
];
