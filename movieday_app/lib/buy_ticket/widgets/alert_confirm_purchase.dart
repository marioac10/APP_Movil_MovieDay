import 'package:flutter/material.dart';
import 'package:movieday_app/buy_ticket/widgets/alert_buy_succesfull.dart';
import 'package:movieday_app/buy_ticket/widgets/wait_pay_ticket.dart';
import 'package:movieday_app/models/ticket_model.dart';
import 'package:movieday_app/services/buy_tickets_service.dart';

  showDialogConfirmationBuyTicket(BuildContext context, TicketModel ticket, Size size) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext newcontext) {
          return AlertDialog(
            elevation: 20,
            title: const Text("Confirmación"),
            content: SizedBox(
              //height: size.height*0.1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Boletos", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(ticket.numBoletos.toString())
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Fecha", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(ticket.fecha!.hour),
                              Text(ticket.fecha!.day.toString()+" "+ticket.fecha!.month)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text("Asientos",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: size.height*0.05,
                      width: size.width*0.5,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ticket.listaAsientos.isEmpty ? [] : ticket.listaAsientos.map((e) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            child: Text(e.seccion+""+e.numAsiento.toString()),
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text("Total",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(ticket.total.toString())
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed:() {
                  Navigator.pop(context);
                }, 
                child: const Text("Cancelar")
              ),
              TextButton(
                onPressed:() {
                  Navigator.of(newcontext).pop();
                  _onPressed(context, ticket);
                }, 
                child: const Text("Confirmar")
              )
            ],
          );
        }
    );
  }

void _onPressed(BuildContext context, TicketModel ticket) async {
  DialogBuilder(context).showLoadingIndicator('Procesando su pago...');
  var response = await postCompra(ticket);
  String message='Error';
  if(response.statusCode == 200){
    // print(response.body);
  }else{
    print(response.body);
  }
  DialogBuilder(context).hideOpenDialog();
  showDialogCorrecto(context);
}

// Future _incrementCounter() async {
//   return Future.delayed(Duration(seconds: 2), () {
//   });
// }