import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildUserListInHiveItemCardWidget extends StatelessWidget {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  const BuildUserListInHiveItemCardWidget({
    super.key,
    required this.name,
    required this.job,
    required this.id,
    required this.createdAt,
  });

  String formatCreatedAt(String dateStr) {
    try {
      final DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat("d MMMM yyyy, h:mm a")
          .format(parsedDate)
          .replaceFirstMapped(
            RegExp(r'(\d{1,2}) '),
            (match) => "${match[1]}${_getOrdinalSuffix(int.parse(match[1]!))} ",
          );
    } catch (e) {
      return "N/A";
    }
  }

  String _getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) return "th";
    switch (number % 10) {
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
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
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
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name - $job",
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ID: ${id.isNotEmpty ? id : 'N/A'}\nCreated At: ${createdAt.isNotEmpty ? formatCreatedAt(createdAt) : 'N/A'}",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 14,
                              ),
                    ),
                  ],
                ),
              ),
              Icon(
                id.isEmpty || createdAt.isEmpty ? Icons.close : Icons.check,
                size: 24,
                color:
                    id.isEmpty || createdAt.isEmpty ? Colors.red : Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
