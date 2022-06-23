import 'package:flutter/material.dart';
import 'package:movieday_app/home/movie_detail.dart';
import 'package:movieday_app/models/movieModel.dart';
import 'package:movieday_app/services/home_service.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Welcome? moviesRightNow;
  Welcome? moviesComingSoon;
  Welcome? moviesPopular;
  int heroTag = 0;
  late Future<void> _allServices;

  @override
  void initState() {
    _allServices = _callAllServices();
    // Future.delayed(Duration.zero,()async{
    //   moviesRightNow = await getNowPlayingMovies();
    //   moviesComingSoon = await getComingSoonMovies();
    //   moviesPopular = await getPopularMovies();
    //   setState(() {
    //     moviesRightNow;
    //     moviesComingSoon;
    //     moviesPopular;
    //   });
    // });
    super.initState();
  }

  Future<bool> _callAllServices() async{
    try{
      await Future.wait([_serviceNowPlaying(),_serviceComingSoon(),_servicePopular()]);
      return true;
    }on Exception catch(e){
      return false;
    }
  }

  Future<void> _serviceNowPlaying() async{
    moviesRightNow = await getNowPlayingMovies();
  }
  Future<void> _serviceComingSoon() async{
    moviesComingSoon = await getComingSoonMovies();
  }
  Future<void> _servicePopular() async{
    moviesPopular = await getPopularMovies();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _allServices,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return _buildProgressIndicator();
        } 
        else if (snapshot.hasError){
          return _buildError();
        }
        else{
          return _NestedScrollMovies(size);
        }
      }
    );
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        children: [
          Text("☹",style: TextStyle(fontSize: 18),),
          Text("Ha ocurrido un error"),
        ],
      ),
    );
  }

  NestedScrollView _NestedScrollMovies(Size size) {
    return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
      return <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(bottom:0.0),
            child: Text("RIGHT NOW", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
          ),
          expandedHeight: 290,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Container(
                  child: Image.network("https://image.tmdb.org/t/p/w300/74xTEgt7R36Fpooo50r9T25onhq.jpg",width: size.width,colorBlendMode: BlendMode.dstOut,fit: BoxFit.cover,color: Colors.blue.withOpacity(0.5),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:60),
                  child: Column(
                    children: [
                      _cardsPeliculas(context)
                    ],
                  ),
                )
              ],
            ),
          ),
        )

      ];
    }, 
    body: ListView(
      children: [
        _buildListViewMovies(moviesComingSoon, "Próximamente"),
        _buildListViewMovies(moviesPopular, "Populares")
      ],
    ),
  );
  }

  Widget _cardsPeliculas(context){
    return moviesRightNow != null ? Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: moviesRightNow!.results!.map((e) => Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildMovieItem(e),
          ),
        )
        ).toList(),
      ),
    ): Container();
    // Container(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Image.network("https://image.tmdb.org/t/p/w300${e.posterPath}"),
        //     ),
        //   )
        // )
  }

  Widget _buildListViewMovies(Welcome? movieList, String movieListTitle){
    return Container(
      height: 290,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(136,14,79,.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0, bottom: 7.0),
            child: Text(movieListTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: movieList!.results != null ? movieList.results!.map((e) => Padding(padding: const EdgeInsets.only(left: 6.0, right: 2.0), child: _buildCardsPeliculas(e),)).toList() : <Widget>[const Center(child: CircularProgressIndicator(),)],
            )
          )
        ],
      ),
    );
  }

  Widget _buildMovieItem(Result movie){
    heroTag += 1;
    movie.heroTag = heroTag;
    return Material(
      elevation: 15.0,
      child: InkWell(
        onTap:() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movie: movie)));
        },
        child: Hero(
          tag: heroTag,
          child: movie.posterPath == null ? Image.asset("assets/imageNotFound.jpg") : Image.network('https://image.tmdb.org/t/p/w300${movie.posterPath}',fit: BoxFit.cover,),
        ),

      ),
    );
  }

  Widget _buildCardsPeliculas(Result movie){
    return Material(
      child: Container(
        width: 126.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: _buildMovieItem(movie),
              ),
              Padding(
                padding: EdgeInsets.only(left:6.0,top:2.0),
                child: Text(movie.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,overflow: TextOverflow.ellipsis),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0, top: 2.0),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.parse(movie.releaseDate.toString())),
                  // movie.releaseDate.toString(),
                  style: TextStyle(fontSize: 18),
                ), 
              )
            ],
          ),
        ),
      ),
    );
  }

 

  void printName(String name) => print(name);


}

