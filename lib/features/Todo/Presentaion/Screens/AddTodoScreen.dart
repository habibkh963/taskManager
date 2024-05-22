import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskmanager/features/Login/presentaion/View/Widget/Shared/custom_text_field.dart';
import 'package:taskmanager/features/Todo/Data/DataProviders/LocalDataBase.dart';

import '../../Domain/entites/Todos.dart';
import '../Blocs/bloc/add_delete_bloc.dart';

class AddPostScreen extends StatelessWidget {
  final Todo? todo;
  AddPostScreen({super.key, this.todo});
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController uid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      body.text = todo!.todo ?? '';
      id.text = todo!.id.toString() ?? '0';
      uid.text = todo!.userId.toString() ?? '0';
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          todo == null ? 'Add Task ' : 'upateTask',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AddDeleteBloc, AddDeleteState>(
        bloc: context.read<AddDeleteBloc>(),
        listener: (context, state) {
          if (state is ErrorState) {
            print(state.msg);
          }
          if (state is SuccessfullState) {
            print('succseful');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                      size: 150.w,
                      controller: body,
                      hintText: 'Task Content',
                      keyboardType: TextInputType.multiline,
                      obscureText: false),
                  CustomTextField(
                      controller: uid,
                      hintText: 'userID',
                      keyboardType: TextInputType.text,
                      obscureText: false),
                  CustomTextField(
                      controller: id,
                      hintText: 'Task ID',
                      keyboardType: TextInputType.text,
                      obscureText: false),
                  CustomTextField(
                      controller: uid,
                      hintText: 'userID',
                      keyboardType: TextInputType.text,
                      obscureText: false),
                  ActionChip(
                      backgroundColor: Colors.indigo,
                      onPressed: () async {
                        context.read<AddDeleteBloc>().add(AddEvent(Todo(
                            todo: body.text,
                            id: int.parse(id.text.trim()),
                            userId: int.parse(uid.text.trim()))));
                      },
                      label: Text(
                        'send',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
