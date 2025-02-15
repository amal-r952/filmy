import 'package:filmy/src/bloc/movie_bloc.dart';
import 'package:filmy/src/models/get_movie_response_model.dart';
import 'package:filmy/src/screens/movie_details_screen.dart';
import 'package:filmy/src/utils/app_toasts.dart';
import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_loading_widget.dart';
import 'package:filmy/src/widgets/build_movies_list_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../widgets/build_custom_appbar_widget.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  MovieBloc movieBloc = MovieBloc();
  List<GetMovieResponseModel> movies = [];
  ScrollController moviesScrollController = ScrollController();
  bool isFetchingMoreMovies = false;
  int pageNumber = 1;
  int totalPages = 1;
  bool isFetchingMovies = true;

  @override
  void initState() {
    super.initState();
    getMovies();
    movieBloc.getMoviesResponse.listen((event) {
      debugPrint("MOVIES COUNT: ${event.results!.length}");
      if (mounted) {
        setState(() {
          movies.addAll(event.results!);
          totalPages = event.totalPages!;
          isFetchingMovies = false;
          isFetchingMoreMovies = false;
        });
      }
    }).onError((error) {
      if (mounted) {
        setState(() {
          isFetchingMoreMovies = false;
          isFetchingMovies = false;
        });
        AppToasts.showErrorToastTop(
            context, "Error fetching movies, Please try again!");
      }
    });
    moviesScrollController.addListener(() {
      if (moviesScrollController.position.pixels ==
              moviesScrollController.position.maxScrollExtent &&
          pageNumber <= totalPages &&
          !isFetchingMoreMovies) {
        fetchMoreMovies();
      }
    });
  }

  @override
  void dispose() {
    moviesScrollController.dispose();
    super.dispose();
  }

  void getMovies() async {
    final isOnline = await InternetConnectionChecker.instance.hasConnection;
    if (isOnline) {
      movieBloc.getMovies(pageNumber: pageNumber);
    } else {
      if (mounted) {
        setState(() {
          isFetchingMovies = false;
          isFetchingMoreMovies = false;
        });
        AppToasts.showErrorToastTop(context, "Please connect to the internet!");
      }
    }
  }

  void fetchMoreMovies() {
    if (pageNumber < totalPages && !isFetchingMoreMovies) {
      if (mounted) {
        setState(() {
          isFetchingMoreMovies = true;
        });
      }
      pageNumber++;
      getMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildCustomAppBarWidget(
        centerTitle: false,
        title: "Movies",
        showBackButton: true,
        preferredHeight: 70,
      ),
      body: isFetchingMovies
          ? const Center(
              child: BuildLoadingWidget(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                controller: moviesScrollController,
                itemCount: movies.length + (isFetchingMoreMovies ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < movies.length) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: BuildMoviesListItemCardWidget(
                          movieResponseModel: movie,
                          onTap: () {
                            push(
                                context,
                                MovieDetailsScreen(
                                  movieId: movie.id!,
                                ));
                          }),
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: BuildLoadingWidget(),
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}
