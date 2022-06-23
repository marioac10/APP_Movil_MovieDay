import 'package:flutter/material.dart';
import 'package:movieday_app/models/ticket_model.dart';
import 'package:movieday_app/services/account_service.dart';
import 'package:movieday_app/services/buy_tickets_service.dart';

class Ticket extends StatefulWidget {
  const Ticket({ Key? key }) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {

  @override
  void initState() {
    super.initState();
  }

  Future<List<TicketModel>> getComprasUser() async{
    String username = await getLocalUsername();
    var tickets = await getCompras(username);
    return tickets;
  }

  late Future<List<TicketModel>> lastCompras = getComprasUser();

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: lastCompras,
      builder: (context, AsyncSnapshot<List<TicketModel>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return waitingCompras(context);
          case ConnectionState.done:
            return comprasUser(snapshot.data!,size);
          default:
            return const Text('Hola mundo');
        }
      }
    );
  }



  Center waitingCompras(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
      primary: false,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 3,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Obteniendo boletos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12),
                textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      ),
    );
  }
  }

  Widget comprasUser(List<TicketModel> listTicket,Size size){
    return (listTicket == null)
      ? Center(
          child: SingleChildScrollView(
            child: Column(
              children: const[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'No se encontraron boletos recientes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
      : listTicket.isEmpty
        ? Center(
            child: SingleChildScrollView(
              child: Column(
                children: const[
                  Text(
                    'No se encontraron boletos recientes'),
                ],
              ),
            ),
          )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: listTicket.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: size.height*0.1,
                    decoration: BoxDecoration(
                      color: Colors.orange[400],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.fromRGBO(203, 67, 53, 1),
                        width: 2
                      )
                    ),
                    child: Row(
                      children: [
                        ClipRRect(child: Image.asset('assets/boleto.png'),borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12))),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:4.0),
                                  child: Text(listTicket[index].nombrePelicula.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Boletos: "+listTicket[index].numBoletos.toString(),),
                                      Text("Total: "+listTicket[index].total.toString())
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Text("Hora: "+listTicket[index].fecha!.hour.toString()+" "+listTicket[index].fecha!.day+""+listTicket[index].fecha!.month)
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                );
              }
            ),
        );
  }

  Widget compras(BuildContext context, List<TicketModel> listTicket){
    return ListView(    
      children: listTicket.map((e) => Text(e.username.toString())).toList(),
    );
  }


