import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskmanager/features/Login/Data/DataProviders/UserLocalDataSourceImpl.dart';
import 'package:taskmanager/features/Login/presentaion/View/Screens/IntrolPageView.dart';
import 'package:taskmanager/features/Login/presentaion/bloc/LogInBloc.dart';
import 'package:taskmanager/features/Todo/Presentaion/Blocs/Cubits/cubit/show_hide_pass_word_cubit.dart';
import 'package:taskmanager/features/Todo/Presentaion/Blocs/Cubits/paginationCubit/pagination_cubit.dart';

import 'InjectionContainer.dart';
import 'features/Login/Domain/entites/User.dart';
import 'features/Login/presentaion/bloc/GetUserBloc.dart';
import 'features/Todo/Data/DataProviders/LocalDataBase.dart';
import 'features/Todo/Presentaion/Blocs/bloc/add_delete_bloc.dart';
import 'features/Todo/Presentaion/Blocs/bloc/get_all_todos_bloc.dart';
import 'features/Todo/Presentaion/Screens/ShowTodoScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependecy_init();
  await TodosLocalDataSource.instance.initializeDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return
          // MultiBlocProvider(
          // providers: [
          // BlocProvider(
          //   create: (context) => dependcy<GetAllTodosBloc>(),
          // ),
          // BlocProvider<AddDeleteBloc>(
          //   create: (context) => dependcy<AddDeleteBloc>(),
          // ),
          // ],
          // child:
          MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<GetUserBloc>(
              create: (context) => dependcy<GetUserBloc>(),
            ),
            // BlocProvider(
            //   create: (context) => dependcy<GetAllTodosBloc>(),
            // ),

            BlocProvider<LogInBloc>(
              create: (context) => dependcy<LogInBloc>(),
            ),
            BlocProvider<ShowHidePassWordCubit>(
              create: (context) => dependcy<ShowHidePassWordCubit>(),
            ),
          ],
          child: BlocListener<GetUserBloc, GetUserState>(
            bloc: dependcy<GetUserBloc>()..add(GetUserEvent()),
            listener: (context, state) async {
              print("fd");
              if (state is GetUserStateLoaded) {
                /// The line `User user = await dependcy<UserLocalDataSource>().getLocalUser();` is fetching the
                /// local user data using the `UserLocalDataSource` class.

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<AddDeleteBloc>(
                        create: (context) => dependcy<AddDeleteBloc>(),
                      ),
                      BlocProvider(
                        create: (context) => dependcy<GetAllTodosBloc>(),
                      ),
                    ],
                    child: ShowTodoScreen(title: 'My Tasks'),
                  ),
                ));
              }
            },
            child: IntrolPageView(),
          ),
        ),
      );
      // );
    });
  }
}
