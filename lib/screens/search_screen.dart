import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:cotufaverse/models/models.dart";
import "package:cotufaverse/provider/movies_provider.dart";
import "package:cotufaverse/widgets/widgets.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  int selectedGenreId = 0;

  Future<List<Movie>> _getMovies() async {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    List<Movie> movies = [];

    if (query.isNotEmpty) {
      movies = await moviesProvider.searchMovies(query);
      if (selectedGenreId != 0) {
        movies = movies
            .where((m) => m.genreIds.contains(selectedGenreId))
            .toList();
      }
    } else if (selectedGenreId != 0) {
      movies = await moviesProvider.getMovieGenre(selectedGenreId);
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    bool showEmptyState = query.isEmpty && selectedGenreId == 0;
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RichText(
          text: const TextSpan(
            text: "Buscar",
            style: TextStyle(
              color: Color.fromARGB(255, 248, 240, 204),
              fontSize: 26,
              fontFamily: "Agrandir",
            ),
            children: [
              TextSpan(
                text: ".",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 197, 39),
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              //barra
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Descubre tu aventura de hoy",
                    hintStyle: TextStyle(color: Color.fromARGB(96, 0, 0, 0)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(136, 0, 0, 0),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              //géneros
              if (moviesProvider.movieGenres.isEmpty)
                const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 197, 39),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: moviesProvider.movieGenres.map((genre) {
                      return FilterTag(
                        label: genre.name.toUpperCase(),
                        isActive: selectedGenreId == genre.id,
                        onTap: () {
                          setState(() {
                            selectedGenreId = (selectedGenreId == genre.id)
                                ? 0
                                : genre.id;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 20),

              //resultados
              if (showEmptyState)
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Icon(
                      Icons.movie_creation_outlined,
                      color: Color.fromARGB(255, 255, 197, 39),
                      size: 100,
                    ),
                  ),
                )
              else
                FutureBuilder(
                  future: _getMovies(),
                  builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 255, 197, 39),
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "No se encontraron resultados.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 248, 240, 204),
                            ),
                          ),
                        ),
                      );
                    }

                    //si hay resultados
                    final movies = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Resultados de la búsqueda (${movies.length})",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 248, 240, 204),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: movies.length,
                          itemBuilder: (_, int index) =>
                              ItemSearch(movie: movies[index]),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
