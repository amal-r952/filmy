import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class BuildUsersListItemCardWidget extends StatefulWidget {
  final String profilePictureUrl;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final Function onTap;
  const BuildUsersListItemCardWidget({
    super.key,
    required this.profilePictureUrl,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.onTap,
  });

  @override
  State<BuildUsersListItemCardWidget> createState() =>
      _BuildUsersListItemCardWidgetState();
}

class _BuildUsersListItemCardWidgetState
    extends State<BuildUsersListItemCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
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
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Image
              BuildCachedNetworkImageWidget(
                height: screenHeight(context, dividedBy: 10),
                width: screenWidth(context, dividedBy: 5),
                boxShape: BoxShape.circle,
                boxFit: BoxFit.cover,
                imageUrl: widget.profilePictureUrl,
              ),
              const SizedBox(width: 16),

              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.firstName} ${widget.lastName}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.emailAddress,
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
      ),
    );
  }
}
