import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:cotufaverse/models/models.dart";
import "package:cotufaverse/provider/movies_provider.dart";
import "package:cotufaverse/widgets/widgets.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:cotufaverse/utils/app_dictionary.dart';

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
            .where((movie) => movie.genreIds.contains(selectedGenreId))
            .toList();
      }
    } else if (selectedGenreId != 0) {
      movies = await moviesProvider.getMovieGenre(selectedGenreId);
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    final Color dynamicTextColor =
        Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFF8F0CC)
        : const Color(0xFF0C123F);
    bool emptyState = query.isEmpty && selectedGenreId == 0;
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(233, 40, 56, 178),
                  Color.fromARGB(233, 12, 18, 63),
                ],
              )
            : null,
        color: isDarkMode ? null : Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: size.height * 0.1,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextWithDoubleColor(
            size: size,
            text1: AppDictionary.translate(context, "search_title"),
            text2: ".",
            padding: const EdgeInsets.all(20.0),
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
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: AppDictionary.translate(context, "search_hint"),
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
                if (emptyState)
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage("assets/images/empty_cotufa.png"),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 5),
                          Text(
                            AppDictionary.translate(context, "no_popcorn"),
                            style: GoogleFonts.poppins(
                              color: dynamicTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                        return Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/empty_cotufa.png",
                                  ),
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  AppDictionary.translate(context, "no_results"),
                                  style: GoogleFonts.poppins(
                                    color: dynamicTextColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                            "${AppDictionary.translate(context, "search_results")} (${movies.length})",
                            style: TextStyle(
                              color: dynamicTextColor,
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
      ),
    );
  }
}
