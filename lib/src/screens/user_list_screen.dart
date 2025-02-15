import 'package:filmy/src/bloc/user_bloc.dart';
import 'package:filmy/src/models/get_user_response_model.dart';
import 'package:filmy/src/screens/add_user_screen.dart';
import 'package:filmy/src/screens/movies_list_screen.dart';
import 'package:filmy/src/utils/app_colors.dart';
import 'package:filmy/src/utils/app_toasts.dart';
import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_custom_appbar_widget.dart';
import 'package:filmy/src/widgets/build_loading_widget.dart';
import 'package:filmy/src/widgets/build_users_list_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserBloc userBloc = UserBloc();
  List<GetUserResponseModel> users = [];
  ScrollController usersScrollController = ScrollController();
  bool isFetchingMoreUsers = false;
  int pageNumber = 1;
  int totalPages = 1;
  bool isFetchingUsers = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
    userBloc.fetchUsersResponse.listen((event) {
      print("FETCHED USERS COUNT: ${event.data!.length}");
      print("TOTAL PAGES COUNT: ${event.totalPages}");
      print("CURRENT PAGE: $pageNumber");
      if (mounted) {
        setState(() {
          users.addAll(event.data!);
          totalPages = event.totalPages!;
          isFetchingUsers = false;
          isFetchingMoreUsers = false;
        });
      }
    }).onError((error) {
      if (mounted) {
        AppToasts.showErrorToastTop(
            context, "Error fetching users, Please try again!");
      }
    });
    usersScrollController.addListener(() {
      if (usersScrollController.position.pixels ==
              usersScrollController.position.maxScrollExtent &&
          pageNumber <= totalPages &&
          !isFetchingMoreUsers) {
        fetchMoreUsers();
      }
    });
  }

  @override
  void dispose() {
    usersScrollController.dispose();
    super.dispose();
  }

  void fetchUsers() async {
    final isOnline = await InternetConnectionChecker.instance.hasConnection;
    if (isOnline) {
      userBloc.fetchUsers(pageNumber: pageNumber);
    } else {
      if (mounted) {
        setState(() {
          isFetchingUsers = false;
          isFetchingMoreUsers = false;
        });
        AppToasts.showErrorToastTop(context, "Please connect to the internet!");
      }
    }
  }

  void fetchMoreUsers() {
    if (pageNumber < totalPages && !isFetchingMoreUsers) {
      if (mounted) {
        setState(() {
          isFetchingMoreUsers = true;
        });
      }
      pageNumber++;
      fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildCustomAppBarWidget(
        centerTitle: false,
        title: "Users",
        showBackButton: false,
        preferredHeight: 70,
      ),
      body: isFetchingUsers
          ? const Center(
              child: BuildLoadingWidget(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                controller: usersScrollController,
                itemCount: users.length + (isFetchingMoreUsers ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < users.length) {
                    final user = users[index];
                    return BuildUsersListItemCardWidget(
                      profilePictureUrl: user.avatar ?? "",
                      firstName: user.firstName ?? "",
                      lastName: user.lastName ?? "",
                      emailAddress: user.email ?? "",
                      onTap: () {
                        push(context, const MoviesListScreen());
                      },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, AddUserScreen());
        },
        backgroundColor: AppColors.primaryColorOrange,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
