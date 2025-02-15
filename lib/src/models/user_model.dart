import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String job;

  @HiveField(2)
  String? id;

  @HiveField(3)
  String? createdAt;

  User({
    required this.name,
    required this.job,
    this.id,
    this.createdAt,
  });
}
