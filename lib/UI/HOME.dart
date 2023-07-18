import 'package:flutter/material.dart';

import '../model/movie.dart';

class MovieList extends StatelessWidget {
  //const MovieList({Key? key}) : super(key: key);
  final List<Movie> movielist= Movie.getMovies() ;



  final List movies= [
    "Titanic",
    "Avatar",
    "Before Sunrise",
    "Transformers",
    "John Wick",
    "Pearl",
    "The Nun",
    "Games of Thrones"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index){
            return Stack(
              children: [

                  Moviecard(movielist[index], context),
                Positioned(
                  top: 40,
                  child:
                    Movieimg(movielist[index].poster),

                ),

              ],
            );}


        // return Card(
        //   elevation: 4.3,
        //   color: Colors.white,
        //   child: ListTile(
        //     leading: CircleAvatar(
        //
        //       child: Container(
        //         width: 200,
        //         height: 300,
        //
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: NetworkImage(movielist[index].poster),
        //             fit: BoxFit.cover,
        //           ),
        //           borderRadius: BorderRadius.circular(12),
        //           color: Colors.blue
        //
        //         ),
        //         child: null,
        //       ),
        //     ),
        //     trailing: Text(". . ."),
        //     title: Text(movielist[index].title),
        //     subtitle:Text(movielist[index].title),
        //       onTap: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => MovieViewd(movieName: movielist.elementAt(index).title,movie: movielist[index] )));
        // },
        //
        //   ),
        // );
      ),
    );
   }
Widget Moviecard( Movie movie, BuildContext context){
  return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 50),
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
              bottom: 8.0,
              left: 55,
              right: 10
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child:
                      Text(movie.title,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),),),
                      Flexible(child:
                      Text("Ratings: ${movie.imdbRating} /10", style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),),)
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(child:
                      Text("Released date : ${movie.released}",style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),),),
                      Flexible(child:
                      Text( movie.runtime,style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),),),
                      Flexible(child:
                      Text(movie.rated,style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    onTap:  () =>{
      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieViewd(movieName: movie.title,movie: movie )))
    },

  );
}


  Widget Movieimg (String imgurl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imgurl ??
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYxMDg1Nzk1MV5BMl5BanBnXkFtZTcwMDk0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg",),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}


class MovieViewd extends StatelessWidget {
  final String movieName;
  final Movie movie;
  const MovieViewd({Key? key, required this.movieName, required this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,

      ),
      body: ListView(
        children: [
          moviethumbnail(thumbnail: movie.poster),
          movieheaderposter(movie: movie),
          moviecast(movie: movie),
          horizonline(),
          Scrollclass(posters: movie.images)

        ],
      ),
    );
  }
}

class moviethumbnail extends StatelessWidget {
  final String thumbnail;
  const moviethumbnail({Key? key, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
           Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 178,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  )
                ),
              ),

              Icon(Icons.play_circle,color: Colors.white,size: 100,)
            ],
          ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),


          ),

          height: 80,
        )

      ],
    );
  }
}

class movieheaderposter extends StatelessWidget {
  final Movie movie;
  const movieheaderposter({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal:16),
        child: Row(
          children: [
            Movieposter(poster: movie.poster),
            SizedBox(width: 16,),
            Expanded(child: Movieheader(movie: movie))

          ],


        ),
    );
  }
}


class Movieheader extends StatelessWidget {
  final Movie movie;
  const Movieheader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("${movie.year} . ${movie.genre}".toUpperCase(),style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.blue
        ),),
        Text(movie.title,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32,
        ),),
        Text.rich( TextSpan(style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w300,

        ),
          children: [
            TextSpan(
              text: movie.plot
            ),
            TextSpan(
              text: " More...",
              style: TextStyle(
                color: Colors.indigoAccent
              )
            )

          ]
        ) )
      ],
    );
  }
}



class Movieposter extends StatelessWidget {

  final String poster;
  const Movieposter({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            )
          ),
        ),
      )
    );
  }
}



class moviecast extends StatelessWidget {
  final Movie movie;
  const moviecast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
      child: Column(
        children: [
          moviefield(field:"Cast",value: movie.actors),
          moviefield(field:"Directors", value:movie.director),
          moviefield(field: "Awards", value: movie.awards)
        ],

      ),
    );
  }
}

class moviefield extends StatelessWidget {
  final String field;
  final String value;
  const moviefield({Key? key, required this.field, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field :" ,style: TextStyle(
          color: Colors.black45,fontSize: 12, fontWeight: FontWeight.w300
        ),),
        Expanded(
          child: Text(value,style: TextStyle(
          color: Colors.black45,fontSize: 12, fontWeight: FontWeight.w300
    ),),
        )
      ],
    );
  }
}

class horizonline extends StatelessWidget {
  //const horizonline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: Colors.grey,
    );
  }
}

class Scrollclass extends StatelessWidget {
  final List<String> posters;
  const Scrollclass({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
          child: Text("More Movie Posters...", style: TextStyle(
            fontSize: 14,
            color: Colors.black45,
          ),),
        ),
        Container(
        height: 200,
        margin: EdgeInsets.only(left: 8),
        child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 8,),
        itemCount: posters.length,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: MediaQuery.of(context).size.width/3,
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(posters[index]),
    fit: BoxFit.cover),

    ),
    ),
    )

        )
    , ),
    ],
    );
  }
}




