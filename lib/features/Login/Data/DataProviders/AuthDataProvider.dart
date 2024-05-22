import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/constants.dart';
import '../../../../core/errors/Exceptions.dart';
import '../../Domain/entites/User.dart';
import '../model/UserModel.dart';
import 'package:http/http.dart' as http;

abstract class AuthDataProvider {
  Future<UserModel> login(String userName, String password);
}

class AuthDataProviderWithHttp implements AuthDataProvider {
  @override
  Future<UserModel> login(userName, password) async {
    try {
      var response = await http.post(Uri.parse(base_url + '/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            {
              "username": userName,
              "password": password,
              "expiresInMins": 30,
            },
          ));
      print(response.body);
      UserModel userfetched = UserModel.fromJson(jsonDecode(response.body));
      print(userfetched.firstName);
      return userfetched;
    } catch (e) {
      print(e);
      throw ServicesException();
    }
  }
}

// class TodoLocalData implements TodosDataProviders {
//   @override
//   Future<List<TodosModel>> getAllTodos() async {
//     try {
//       print("response");
//       var response = await http.get(Uri.parse(base_url + '/todos'));
//       print(response);
//       List<TodosModel> todos = jsonDecode(response.body)['todos']
//           .map<TodosModel>((e) => TodosModel.fromJson(e))
//           .toList();
//       print(response.body);
//       return todos;
//     } catch (e) {
//       print(e);
//       throw ServicesException();
//     }
//   }

//   @override
//   Future<Unit> addTodo(Todo todo) async {
//     try {
//       var response = await http.post(Uri.parse(base_url + '/todos'),
//           body: jsonEncode(
//             {
//               "userId": todo.userId,
//               "id": todo.id,
//               "todo": todo.todo,
//               "completed": todo.completed
//             },
//           ));
//       int id = jsonDecode(response.body)['id'];
//       return unit;
//     } catch (e) {
//       print(e);
//       throw ServicesException();
//     }
//   }

//   @override
//   Future<Unit> deleteTodo(int id) async {
//     try {
//       var response = await http.post(Uri.parse(base_url + "/todos/$id"));

//       return unit;
//     } catch (e) {
//       throw ServicesException();
//     }
//   }
// }
