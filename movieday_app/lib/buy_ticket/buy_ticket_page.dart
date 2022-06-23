import 'package:flutter/material.dart';

import 'package:movieday_app/animations/animations.dart';
import 'package:movieday_app/buy_ticket/movie_screen_teather.dart';
import 'package:movieday_app/buy_ticket/movie_seat_legend.dart';
import 'package:movieday_app/buy_ticket/movie_seats.dart';
import 'package:movieday_app/buy_ticket/widgets/alert_confirm_purchase.dart';
import 'package:movieday_app/core/data/data.dart';
import 'package:movieday_app/models/movieModel.dart';
import 'package:movieday_app/models/ticket_model.dart';
import 'package:movieday_app/services/account_service.dart';
import 'package:uuid/uuid.dart';

import 'movie_appbar.dart';
import 'movie_dates.dart';

class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Result? movie;

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage>
    with TickerProviderStateMixin {
  late final BookingPageAnimationController _controller;
  TicketModel ticket = TicketModel(listaAsientos: []);
  var uuid = Uuid();
  @override
  void initState() {
    widget.movie!.dates = dates;
    widget.movie!.seats = seats;
    _controller = BookingPageAnimationController(
      buttonController: AnimationController(
        duration: const Duration(milliseconds: 750),
        vsync: this,
      ),
      contentController: AnimationController(
        duration: const Duration(milliseconds: 750),
        vsync: this,
      ),
    );
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _controller.buttonController.forward();
      await _controller.buttonController.reverse();
      await _controller.contentController.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAnimatedOpacity(
            animation: _controller.topOpacityAnimation,
            child: MovieAppBar(title: widget.movie!.title.toString()),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              width: w,
              height: h * .9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.topOpacityAnimation,
                      child: SizedBox(
                        height: h * .075,
                        child: MovieDates(dates: widget.movie!.dates, ticket: ticket),
                      ),
                    ),
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.topOpacityAnimation,
                      child: SizedBox(
                        height: h * .2,
                        width: w,
                        child: MovieTeatherScreen(
                          image: widget.movie!.posterPath.toString(),
                          maxHeigth: h,
                          maxWidth: w,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    CustomAnimatedOpacity(
                      animation: _controller.bottomOpacityAnimation,
                      child: MovieSeats(seats: widget.movie!.seats, ticket: ticket,),
                    ),
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.bottomOpacityAnimation,
                      child: const MovieSeatLegend(),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () async{
                  // if(ticket.listaAsientos != null){
                  //   ticket.listaAsientos?.forEach((e) { print(e.numAsiento); });
                  // }
                  // print(ticket.listaAsientos.length.toString());
                  ticket.username = await getLocalUsername();
                  ticket.idpelicula = widget.movie!.id.toString();
                  ticket.nombrePelicula = widget.movie?.title;
                  ticket.numBoletos = ticket.listaAsientos.length.toString();
                  int cantidadBoletos = ticket.listaAsientos.length; 
                  ticket.total = (cantidadBoletos * 45).toString();
                  // print(0*45);
                  ticket.claveTiket = uuid.v1();
                  // print(ticket.username);
                  // print(ticket.claveTiket);
                  // print(ticket.fecha);
                  // print(ticket.idpelicula);
                  // print(ticket.numBoletos);
                  showDialogConfirmationBuyTicket(context, ticket, size);
                  //print(ticket.fecha?.hour.toString());
                  // ticket.listaAsientos.forEach((e) { 
                  //   print("Asiento :"+e.seccion+" "+e.numAsiento.toString());
                  // });
                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //     transitionDuration: transitionDuration,
                  //     reverseTransitionDuration: transitionDuration,
                  //     pageBuilder: (_, animation, ___) {
                  //       return FadeTransition(
                  //         opacity: animation,
                          
                  //       );
                  //     },
                  //   ),
                  // );
                },
                child: AnimatedBuilder(
                  animation: _controller.buttonController,
                  builder: (_, child) {
                    final size = _controller
                        .buttonSizeAnimation(
                          Size(w * .7, h * .06),
                          Size(w * 1.2, h * 1.1),
                        )
                        .value;
                    final margin =
                        _controller.buttonMarginAnimation(h * .03).value;
                    return Container(
                      width: size.width,
                      height: size.height,
                      margin: EdgeInsets.only(bottom: margin),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: h * .05,
              child: const IgnorePointer(
                child: Text(
                  'Comprar boleto',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}