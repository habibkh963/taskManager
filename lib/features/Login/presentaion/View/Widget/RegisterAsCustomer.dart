import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskmanager/InjectionContainer.dart';
import 'package:taskmanager/features/Login/presentaion/bloc/GetUserBloc.dart';
import 'package:taskmanager/features/Login/presentaion/bloc/LogInBloc.dart';
import 'package:taskmanager/features/Todo/Presentaion/Blocs/Cubits/cubit/show_hide_pass_word_cubit.dart';
import 'package:taskmanager/features/Todo/Presentaion/Screens/ShowTodoScreen.dart';

import '../../../../Todo/Presentaion/Blocs/Cubits/paginationCubit/pagination_cubit.dart';
import '../../../../Todo/Presentaion/Blocs/bloc/add_delete_bloc.dart';
import '../../../../Todo/Presentaion/Blocs/bloc/get_all_todos_bloc.dart';
import 'Shared/custom_text_field.dart';

class RegisterAsCustomer extends StatelessWidget {
  RegisterAsCustomer({
    super.key,
  });
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      child: Column(children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Wrap(
            children: [
              Text(
                'Task Manager',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigo, fontSize: 25.sp)!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                'by Al Habib khaddam',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigoAccent, fontSize: 12.sp)!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          width: 400.w,
          height: 70.h,
          child: CustomTextField(
            controller: userName,
            hintText: 'user Name',
            isUser: true,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(
          width: 400.w,
          height: 70.h,
          child: BlocBuilder<ShowHidePassWordCubit, ShowHidePassWordState>(
            bloc: context.read<ShowHidePassWordCubit>(),
            builder: (context, state) {
              return CustomTextField(
                controller: passWord,
                hintText: 'password',
                suffix: IconButton(
                    onPressed: () {
                      context.read<ShowHidePassWordCubit>().showAndhidePass();
                    },
                    icon: state is HidePassWord
                        ? Icon(Icons.remove_red_eye_outlined)
                        : state is ShowPassWord
                            ? Icon(Icons.visibility_off_outlined)
                            : SizedBox()),
                keyboardType: TextInputType.visiblePassword,
                obscureText: context.read<ShowHidePassWordCubit>().showPass,
              );
            },
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        BlocConsumer<LogInBloc, LogInMainState>(
            listener: (context, state) {
              if (state is LogInSuccessfullState) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<AddDeleteBloc>(
                        create: (context) => dependcy<AddDeleteBloc>(),
                      ),
                      BlocProvider(
                        create: (context) => dependcy<GetAllTodosBloc>(),
                      ),
                      BlocProvider<GetUserBloc>(
                        create: (context) => dependcy<GetUserBloc>(),
                      ),
                    ],
                    child: ShowTodoScreen(title: 'My Tasks'),
                  ),
                ));
              }
            },
            bloc: context.read<LogInBloc>(),
            builder: (context, state) {
              return state is LogInMainStateLoading
                  ? CircularProgressIndicator(
                      color: Colors.indigo,
                    )
                  : state is LogInErrorState || state is LogInMainStateInitial
                      ? ElevatedButton(
                          onPressed: () {
                            context
                                .read<LogInBloc>()
                                .add(LogInEvent(userName.text, passWord.text));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 15.w)),
                          child: Text(
                            'LogIn',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp)!
                                    .copyWith(fontWeight: FontWeight.w900),
                          ),
                        )
                      : SizedBox();
            }),
      ]),
    );
  }
}
