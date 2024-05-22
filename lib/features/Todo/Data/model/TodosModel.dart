import '../../Domain/entites/Todos.dart';

class TodosModel extends Todo {
  TodosModel({super.userId, super.id, super.todo, super.completed});

  factory TodosModel.fromJson(Map<String, dynamic> json) {
    return TodosModel(
        userId: json['userId'],
        id: json['id'],
        todo: json['todo'],
        completed: json['completed'].runtimeType == bool
            ? json['completed']
            : json['completed'] == 1
                ? true
                : false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = super.userId;
    data['id'] = super.id;
    data['todo'] = super.todo;
    data['completed'] = super.completed! ? 1 : 0;
    return data;
  }
}
