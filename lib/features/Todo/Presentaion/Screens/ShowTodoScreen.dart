import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:taskmanager/features/Todo/Presentaion/Blocs/Cubits/paginationCubit/pagination_cubit.dart';

import '../../../../InjectionContainer.dart';
import '../../../Login/Data/DataProviders/UserLocalDataSourceImpl.dart';
import '../../../Login/presentaion/bloc/GetUserBloc.dart';
import '../Blocs/bloc/add_delete_bloc.dart';
import '../Blocs/bloc/get_all_todos_bloc.dart';
import 'AddTodoScreen.dart';

class ShowTodoScreen extends StatefulWidget {
  const ShowTodoScreen({super.key, required this.title});

  final String title;

  @override
  State<ShowTodoScreen> createState() => _ShowTodoScreenState();
}

class _ShowTodoScreenState extends State<ShowTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.indigo,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: dependcy<AddDeleteBloc>(),
                      child: AddPostScreen(),
                    ),
                  ));
                }),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.read<GetAllTodosBloc>()..add(GetAllTodosEvent());
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.indigo,
            ),
          ),
          title: FutureBuilder(
              future: dependcy<UserLocalDataSource>().getLocalUser(),
              builder: (context, snapShot) {
                return snapShot.hasData
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 20.r,
                            backgroundImage:
                                NetworkImage(snapShot.data!.image!),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${snapShot.data!.firstName ?? ''}\'s \nTasks",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      )
                    : CircularProgressIndicator();
              }),
        ),
        body: BlocListener<AddDeleteBloc, AddDeleteState>(
          listener: (context, state) {
            if (state is SuccessfullState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  actionOverflowThreshold: 0,
                  content: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  )));
            }
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  actionOverflowThreshold: 0,
                  content: Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      state.msg,
                      style: TextStyle(color: Colors.white),
                    ),
                  )));
            }
          },
          child: SafeArea(
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  child: BlocBuilder<GetAllTodosBloc, GetAllTodosState>(
                    bloc: context.read<GetAllTodosBloc>()
                      ..add(GetAllTodosEvent()),
                    builder: (context, state) {
                      if (state is GetAllTodoLoading) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: Colors.indigo),
                        );
                      }
                      if (state is LoadingErrorState) {
                        return Center(
                          child: Text(
                            state.msg,
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      if (state is GetAllTodosLoaded) {
                        return ListView.builder(
                            itemCount: state.todo.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Slidable(
                                    key: const ValueKey(0),
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dragDismissible: false,
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) async {
                                            context.read<AddDeleteBloc>().add(
                                                DeleteEvent(
                                                    state.todo[index].id!));
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          label: 'Delete',
                                          spacing: 6,
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                value:
                                                    dependcy<AddDeleteBloc>(),
                                                child: AddPostScreen(
                                                    todo: state.todo[index]!),
                                              ),
                                            ));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          backgroundColor: Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'edit',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      margin: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 1,
                                              color: Colors.black26,
                                              spreadRadius: 1)
                                        ],
                                        color: Colors.indigo,
                                        borderRadius:
                                            BorderRadius.circular(15.w),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0.w),
                                                    child: Text(
                                                        state.todo[index].todo!,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.sp)),
                                                  )),
                                              SizedBox(
                                                height: 60.h,
                                                child: VerticalDivider(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              RotatedBox(
                                                quarterTurns: 1,
                                                child: Text(
                                                  state.todo[index].completed!
                                                      ? 'Completed'
                                                      : 'Binding',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8.sp),
                                                ),
                                              )
                                            ]),
                                          ),
                                          const Divider(
                                            height: 0.5,
                                            color: Colors.white,
                                          ),
                                          Container(
                                              margin: EdgeInsets.zero,
                                              padding: EdgeInsets.zero,
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    style: ButtonStyle(
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero)),
                                                    child: Text(
                                                        'Mark as Completed',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 12.sp)),
                                                    onPressed: () {},
                                                  ),
                                                  Icon(
                                                    Icons.done_all,
                                                    color: Colors.green,
                                                    size: 10.sp,
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                      return SizedBox();
                    },
                  ))),
        ),
        bottomNavigationBar: Card(
          margin: EdgeInsets.zero,
          elevation: 4,
          child: NumberPaginator(
            // by default, the paginator shows numbers as center content
            numberPages: 10,
            onPageChange: (int index) {},
          ),
        ));
  }
}
