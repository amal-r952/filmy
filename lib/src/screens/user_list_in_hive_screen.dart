import 'package:filmy/src/models/user_model.dart';
import 'package:filmy/src/widgets/build_user_list_in_hive_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/build_custom_appbar_widget.dart';

class UserListInHiveScreen extends StatelessWidget {
  final Box<User> _userBox = Hive.box<User>('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildCustomAppBarWidget(
        centerTitle: false,
        title: "Users in Hive",
        showBackButton: true,
        preferredHeight: 70,
      ),
      body: _userBox.isEmpty
          ? Center(
              child: Text(
                'No users added.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: _userBox.length,
              itemBuilder: (context, index) {
                final user = _userBox.getAt(index);

                if (user == null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Invalid user data.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  );
                }

                return BuildUserListInHiveItemCardWidget(
                  name: user.name,
                  job: user.job,
                  id: user.id ?? '',
                  createdAt: user.createdAt ?? '',
                );
              },
            ),
    );
  }
}
