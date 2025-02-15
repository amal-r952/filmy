import 'dart:convert';

import 'package:filmy/src/app.dart';
import 'package:filmy/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("CALLBACK DISPATCHER TRIGGERED FOR TASK: $task");

    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    final box = await Hive.openBox<User>('users');

    print("OPENED HIVE BOX, TOTAL USERS: ${box.length}");

    for (int i = 0; i < box.length; i++) {
      User? user = box.getAt(i);
      print("PROCESSING USER AT INDEX: $i, NAME: ${user?.name}");

      if (user != null && user.id == null) {
        try {
          final response = await http.post(
            Uri.parse('https://reqres.in/api/users'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'name': user.name, 'job': user.job}),
          );

          print(
              "API RESPONSE:- STATUS CODE: ${response.statusCode} \nBODY: ${response.body}");

          if (response.statusCode == 201) {
            final responseData = json.decode(response.body);

            User updatedUser = User(
              name: user.name,
              job: user.job,
              id: responseData['id'],
              createdAt: DateTime.parse(responseData['createdAt']).toString(),
            );

            await box.putAt(i, updatedUser);
            print("USER UPDATED SUCCESSFULLY: ${updatedUser.name}");
          }
        } catch (e) {
          print("ERROR SYNCING USER: $e");
        }
      }
    }

    print("CALLBACK DISPATCHER EXECUTION COMPLETED");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  final box = await Hive.openBox<User>('users');
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  print("WORK MANAGER INITIALIZED");
  await Workmanager().registerPeriodicTask(
    "syncOfflineUsers",
    "syncOfflineUsers",
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
    frequency: const Duration(minutes: 15),
  );
  print("TASK REGISTERED");
  runApp(const MyApp());
}
