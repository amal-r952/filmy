import 'package:filmy/src/models/get_movie_response_model.dart';
import 'package:filmy/src/utils/urls.dart';
import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildMoviesListItemCardWidget extends StatefulWidget {
  final GetMovieResponseModel movieResponseModel;
  final Function onTap;
  const BuildMoviesListItemCardWidget({
    super.key,
    required this.movieResponseModel,
    required this.onTap,
  });

  @override
  State<BuildMoviesListItemCardWidget> createState() =>
      _BuildMoviesListItemCardWidgetState();
}

class _BuildMoviesListItemCardWidgetState
    extends State<BuildMoviesListItemCardWidget> {
  String formatDate(DateTime? date) {
    if (date == null) return "No Date";

    String day = DateFormat('E').format(date);
    String dayWithSuffix = "${date.day}${getDaySuffix(date.day)}";
    String month = DateFormat('MMM').format(date);
    String year = DateFormat('y').format(date);

    return "$day $dayWithSuffix $month $year";
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Profile Image
            BuildCachedNetworkImageWidget(
              borderRadius: BorderRadius.circular(5),
              height: screenHeight(context, dividedBy: 12),
              width: screenWidth(context, dividedBy: 4),
              boxShape: BoxShape.rectangle,
              boxFit: BoxFit.cover,
              imageUrl:
                  "${Urls.movieImageUrl}${widget.movieResponseModel.backdropPath!}}",
            ),
            const SizedBox(width: 16),

            // User Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.movieResponseModel.title!,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatDate(widget.movieResponseModel.releaseDate),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.7),
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
              ),
              onPressed: () {
                widget.onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
