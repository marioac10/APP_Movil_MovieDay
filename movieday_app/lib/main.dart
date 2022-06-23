import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieday_app/account/account.dart';
import 'package:movieday_app/account/login.dart';
import 'package:movieday_app/home/all_movies.dart';
import 'package:movieday_app/home/movie_detail.dart';
import 'package:movieday_app/models/movieModel.dart';
import 'package:movieday_app/services/home_service.dart';
import 'package:movieday_app/ticket/tickets.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color1 = const {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };
  MaterialColor colorVino = MaterialColor(0xFF880E4F, color1);

  Map<int, Color> color2 = const {
    50:Color.fromRGBO(203, 67, 53, .1),
    100:Color.fromRGBO(203, 67, 53, .2),
    200:Color.fromRGBO(203, 67, 53, .3),
    300:Color.fromRGBO(203, 67, 53, .4),
    400:Color.fromRGBO(203, 67, 53, .5),
    500:Color.fromRGBO(203, 67, 53, .6),
    600:Color.fromRGBO(203, 67, 53, .7),
    700:Color.fromRGBO(203, 67, 53, .8),
    800:Color.fromRGBO(203, 67, 53, .9),
    900:Color.fromRGBO(203, 67, 53, 1),
  };
  MaterialColor colorOrange = MaterialColor(0xFFCB4335, color2);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieDay',
      theme: ThemeData(
        primarySwatch: colorOrange,
      ),
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _paginaActual=0;
  int heroTag = 0;
  List<Widget> _paginas = [
    Home(),
    Ticket(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MovieDay"),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {},),
        actions: [
          IconButton(onPressed:() {
            showSearch(
              context: context, 
              delegate: MySearchDelegate()
            );
          }, icon: Icon(Icons.search))
        ],
      ),
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(203, 67, 53, 1),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            _paginaActual = value;
          });
        },
        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Boletos"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle),label: "Cuenta"),
        ]
      ),

    );
  }
}

class MySearchDelegate extends SearchDelegate {
  Welcome? movies;
  int heroTag = 0;
  //MySearchDelegate(this.heroTag);
  
  @override
  ThemeData appBarTheme(BuildContext context) {
    
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(203, 67, 53, 1),),
      primaryColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(
       cursorColor: Colors.white,
       selectionHandleColor: Colors.white,
       selectionColor: Colors.white
      ),
    );
  }

  List<String> searchSuggestions= [
      "The Batman",
      "Spider-Man",
      "Sonic",
      "The Avergers",
      "Doctor Strange"
    ];
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed:() {
        close(context, null);
      }, 
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      )
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
        onPressed:() {
          if(query.isEmpty){
            close(context, null);
          }else{
            query = "";
          }
        }, 
        icon: const Icon(Icons.clear)
      ),

    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement buildResults
    return Container(
      child: FutureBuilder(
        future: searchMovies(query),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError){
            return Center(child: Text("Ha ocurrido un error"),);
          }
          else{
            movies = snapshot.data as Welcome;
            print(movies?.results);
            return gridViewMovies(context,size,movies);
          }
        },
      )
    );
  }

  Widget gridViewMovies(context,Size size, Welcome? movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: movies?.results == null 
          ? [Center(child: Text(""),)] 
          : movies!.results!.map((movie) => _cardsMovies(context, movie)).toList()
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> suggestions = searchSuggestions.where((e) {
      final result = e.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context,index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );

      }
    );
  }

  Widget _cardsMovies(context,Result movie){
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        // decoration: BoxDecoration(color: Colors.amber),
        //width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: _movieItem(context,movie),
              ),
              Padding(
                padding: const EdgeInsets.only(left:6.0,top:2.0,),
                child: Text(movie.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,overflow: TextOverflow.ellipsis),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0, top: 2.0),
                child: Text(
                  movie.releaseDate == null 
                  ? "00-00-00"
                  : DateFormat('yyyy-MM-dd').format(DateTime.parse(movie.releaseDate.toString())),
                  //movie.releaseDate.toString(),
                  style: TextStyle(fontSize: 18),
                ), 
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _movieItem(context,Result movie){
    heroTag += 1;
    movie.heroTag = heroTag;
    return SizedBox(
      height: 200,
      child: Material(
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
      ),
    );
  }










}

  