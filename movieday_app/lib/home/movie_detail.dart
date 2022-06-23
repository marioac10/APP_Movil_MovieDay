import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieday_app/buy_ticket/buy_ticket_page.dart';
import 'package:movieday_app/models/cast_crew.dart';
import 'package:movieday_app/models/movieModel.dart';
import 'package:movieday_app/models/movie_actor.dart';
import 'package:movieday_app/models/movie_detail_model.dart';
import 'package:movieday_app/services/home_service.dart';

class MovieDetail extends StatefulWidget {
  final Result? movie;
  const MovieDetail({ Key? key,this.movie}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailModel? movieDetalle;
  MovieActor? movieActor;
  int heroTag = 0;
  List<CastCrew> castCrew = [];
  bool isLoading = true;

  @override
  void initState() {
    heroTag = widget.movie!.heroTag;
    Future.delayed(Duration.zero,() async{
      String id = widget.movie!.id.toString();
      movieDetalle = await getMovieDetail(id);
      movieActor = await getMovieActor(id);
      // movieActor?.cast?.forEach((c)=> castCrew.add(CastCrew(
      //   id: c.castId,
      //   name: c.name, 
      //   subname: c.character,
      //   imagePath: c.profilePath, 
      //   personType: "Actores")
      // ));
      
      setState(() {
        movieDetalle;
        movieActor;
      });
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }


  String getMovieDuration(int? runtTime){
    if(runtTime == null) return "No data";
    double movieHours = runtTime / 60;
    int movieMinutes = ((movieHours.floor())*60).round(); 
    return '${movieHours.floor()}h ${movieMinutes}min';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final moviePoster = Container(
      height: 350.0,
      padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Center(
        child: Card(
          elevation: 15.0,
          child: Hero(
            tag: widget.movie!.heroTag, 
            child: Image.network('https://image.tmdb.org/t/p/w300${widget.movie!.posterPath}', fit: BoxFit.cover,)),
        ),
      ),
    );

    final movieTitle = Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom:8.0),
        child: Text(widget.movie!.title.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, overflow: TextOverflow.ellipsis),),
      ),
    );

    final movieTicket = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(movieDetalle != null ? getMovieDuration(movieDetalle!.runtime) : '',style: TextStyle(fontSize: 14.0),),
        Container(
          height: 20.0,
          width: 1.5,
          color: Colors.white70,
        ),
        Text('Fecha de estreno: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.movie!.releaseDate.toString()))}', style: TextStyle(fontSize: 14.0),),
        TextButton(
          style: TextButton.styleFrom(
            shape: StadiumBorder(),
            elevation: 15.0,
            backgroundColor: Colors.red[700]
          ),
          child: Text("Tickets", style: TextStyle(color: Colors.white),),
          onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyTicketPage(movie: widget.movie)));
          }, 
        )
      ],
    );

    final genresList = Container(
      height: size.height*0.06,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: movieDetalle == null ? [] : movieDetalle!.genres!.map((e) => Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: FilterChip(
              elevation: 15.0,
                backgroundColor: Colors.red[400],
                labelStyle: TextStyle(fontSize: 18.0),
                label: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(e.name.toString(), style: TextStyle(color: Colors.white),),
                ), 
                onSelected:(value) {},
              ),
          )
          ).toList(),
        ),
      ),
    );

    final movieSinopsis = Container(
      padding: EdgeInsets.only(left: 8.0, right:8.0, bottom:2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.white,),
          genresList,
          Divider(color: Colors.white,),
          Text("Sinopsis",style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, ),),
          SizedBox(height: 10.0,),
          Text(widget.movie!.overview.toString(),textAlign: TextAlign.justify,style: TextStyle(fontSize: 14.0),),
          SizedBox(height: 10.0,)
        ],
      ),
    );

    final actorContent = Container(
      height: size.height*0.2,
      padding: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
            child: Text("Actores",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: movieActor == null ? <Widget>[Center(child: CircularProgressIndicator())] : movieActor!.cast!.map((e) => Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Container(
                  height: 65.0,
                  width: size.width*0.25,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28.0,
                        backgroundImage: e.profilePath != null 
                        ? NetworkImage("https://image.tmdb.org/t/p/w154/${e.profilePath}") 
                        : AssetImage('assets/user.jpg') as ImageProvider
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(e.name.toString(), style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),),
                      ),
                      Text(e.character.toString(), style: TextStyle(fontSize: 8.0,overflow: TextOverflow.ellipsis),)

                    ],
                  ),
                ),
              )).toList() ,
            )
          )

        ],
      ),
    );
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Detalle-Película",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        color: const Color.fromRGBO(136,14,79,.5),
        child: ListView(
          children: [
            moviePoster,
            movieTitle,
            movieTicket,
            movieSinopsis,
            actorContent
          ],
        ),
      ),
    );
  }
}