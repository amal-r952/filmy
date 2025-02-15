import 'package:filmy/src/bloc/movie_bloc.dart';
import 'package:filmy/src/models/movie_response_model.dart';
import 'package:filmy/src/utils/app_toasts.dart';
import 'package:filmy/src/utils/urls.dart';
import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_cached_network_image_widget.dart';
import 'package:filmy/src/widgets/build_custom_appbar_widget.dart';
import 'package:filmy/src/widgets/build_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieBloc movieBloc = MovieBloc();

  @override
  void initState() {
    fetchMovieDetails();
    super.initState();
  }

  fetchMovieDetails() async {
    final isOnline = await InternetConnectionChecker.instance.hasConnection;
    if (isOnline) {
      movieBloc.getMovieDetails(movieId: widget.movieId);
    } else {
      AppToasts.showErrorToastTop(context, "Please connect to the internet!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const BuildCustomAppBarWidget(
        centerTitle: false,
        title: "Movie Details",
        showBackButton: true,
        preferredHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<MovieResponseModel>(
          stream: movieBloc.getMovieDetailsResponse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: BuildLoadingWidget());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: textTheme.bodyLarge,
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No movie details available.',
                  style: textTheme.bodyLarge,
                ),
              );
            }

            final movie = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movie.title ?? 'N/A',
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),

                  // Release Date
                  if (movie.releaseDate != null)
                    Text(
                      'Release Date: ${formatDate(movie.releaseDate!)}',
                      style: textTheme.bodyMedium,
                    ),

                  // Poster Image
                  const SizedBox(height: 16),
                  if (movie.posterPath != null)
                    Center(
                      child: BuildCachedNetworkImageWidget(
                        borderRadius: BorderRadius.circular(10),
                        height: screenHeight(context, dividedBy: 2),
                        width: screenWidth(context),
                        boxShape: BoxShape.rectangle,
                        boxFit: BoxFit.cover,
                        imageUrl: "${Urls.movieImageUrl}${movie.posterPath!}}",
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Genres
                  if (movie.genres != null && movie.genres!.isNotEmpty)
                    Text(
                      'Genres: ${movie.genres!.map((genre) => genre.name).join(', ')}',
                      style: textTheme.bodyLarge,
                    ),
                  const SizedBox(height: 16),

                  // Runtime
                  if (movie.runtime != null)
                    Text(
                      'Runtime: ${movie.runtime} minutes',
                      style: textTheme.bodyLarge,
                    ),
                  const SizedBox(height: 16),

                  // Overview
                  if (movie.overview != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overview:',
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.overview!,
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),

                  // Rating
                  if (movie.voteAverage != null && movie.voteCount != null)
                    Row(
                      children: [
                        Text(
                          'Rating:',
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage!.toStringAsFixed(1),
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${movie.voteCount} votes)',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final daySuffix = getDaySuffix(date.day);
    return '${date.day}$daySuffix ${getMonthName(date.month)} ${date.year}';
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
