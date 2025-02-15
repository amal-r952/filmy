import 'dart:convert';

import 'package:filmy/src/screens/user_list_in_hive_screen.dart';
import 'package:filmy/src/utils/app_toasts.dart';
import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../widgets/build_custom_appbar_widget.dart';
import '../widgets/build_elevated_button.dart';
import '../widgets/build_textfield_widget.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final Box<User> _userBox = Hive.box<User>('users');
  bool isAddingUser = false;

  Future<void> addNewUser() async {
    if (mounted) {
      setState(() {
        isAddingUser = true;
      });
    }
    try {
      String name = nameController.text.trim();
      String job = jobController.text.trim();

      if (name.isNotEmpty && job.isNotEmpty) {
        print("NAME: $name, JOB: $job");
        print("CHECKING IF USER EXISTS");
        bool userExists =
            _userBox.values.any((user) => user.name == name && user.job == job);

        if (!userExists) {
          print("USER DOESN'T EXIST");
          print("CHECKING INTERNET STATUS");
          final isOnline =
              await InternetConnectionChecker.instance.hasConnection;
          print("INTERNET STATUS: $isOnline");

          if (!isOnline) {
            print("DEVICE OFFLINE");
            print("SAVING LOCALLY");
            final newUser = User(
              name: name,
              job: job,
              id: null,
              createdAt: null,
            );
            _userBox.add(newUser);
            AppToasts.showInfoToastTop(context, "User saved offline");
          } else {
            try {
              print("DEVICE ONLINE");
              print("CALLING API");
              final response = await http.post(
                Uri.parse('https://reqres.in/api/users'),
                headers: {'Content-Type': 'application/json'},
                body: json.encode({'name': name, 'job': job}),
              );
              print(
                  "API RESPONSE:-  STATUS CODE: ${response.statusCode} \nBODY: ${response.body}");

              if (response.statusCode == 201) {
                final responseData = json.decode(response.body);
                final newUser = User(
                  name: name,
                  job: job,
                  id: responseData['id'],
                  createdAt:
                      DateTime.parse(responseData['createdAt']).toString(),
                );
                _userBox.add(newUser);

                AppToasts.showSuccessToastTop(
                    context, "User added successfully!");
              } else {
                AppToasts.showErrorToastTop(
                    context, "Failed to add user online!");
              }
            } catch (e) {
              print("CALLING API FAILED: $e");
              AppToasts.showErrorToastTop(context, "Error adding user: $e");
            }
          }
        } else {
          print("USER ALREADY EXISTS IN HIVE");
          AppToasts.showInfoToastTop(context, "User already exists!");
        }
      } else {
        print("NOT ALL FIELDS ARE COMPLETE");
        AppToasts.showInfoToastTop(context, "Please fill all the fields!");
      }
    } catch (e) {
      print("ERROR: $e");
      AppToasts.showErrorToastTop(
          context, "Some error occurred, Please try again! ");
    } finally {
      if (mounted) {
        setState(() {
          isAddingUser = false;
          nameController.clear();
          jobController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildCustomAppBarWidget(
        centerTitle: false,
        title: "Add user",
        showBackButton: true,
        preferredHeight: 70,
        showTrailingIcon: true,
        onTrailingIconPressed: () {
          push(context, UserListInHiveScreen());
        },
        trailingIcon: const Icon(Icons.list_rounded),
        trailingIconSize: 22,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Name',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 10),
            BuildTextField(
              fillColor: Theme.of(context).cardColor,
              textEditingController: nameController,
              textColor: Theme.of(context).dividerColor,
              hintText: 'Enter the user name',
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              showBorder: true,
              showAlwaysErrorBorder: false,
            ),
            const SizedBox(height: 16),
            Text(
              ' Job',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 10),
            BuildTextField(
              fillColor: Theme.of(context).cardColor,
              textColor: Theme.of(context).dividerColor,
              textEditingController: jobController,
              hintText: 'Enter the job title',
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Job title is required';
                }
                return null;
              },
              showBorder: true,
              showAlwaysErrorBorder: false,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: BuildElevatedButton(
                txt: isAddingUser ? null : 'Submit',
                onTap: isAddingUser ? () {} : addNewUser,
                backgroundColor: AppColors.primaryColorOrange,
                borderRadiusTopLeft: 10,
                borderRadiusTopRight: 10,
                borderRadiusBottomLeft: 10,
                borderRadiusBottomRight: 10,
                height: screenHeight(context, dividedBy: 18),
                width: screenWidth(context),
                textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                child: isAddingUser
                    ? BuildLoadingWidget(
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
