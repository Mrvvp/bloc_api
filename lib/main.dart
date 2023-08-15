import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_api/models/user_model.dart';
import 'package:bloc_api/repos/repository.dart';
import 'blocs/app_bloc.dart';
import 'blocs/app_event.dart';
import 'blocs/app_state.dart';

void main (){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp
      (debugShowCheckedModeBanner: false,
        home: RepositoryProvider(
          create: (context) => UserRepository(),
          child: const Home(),
        )
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserBloc(
      RepositoryProvider.of<UserRepository>(context),
    )..add(LoadUserEvent()),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("MyApp"),
          ),
          body: BlocBuilder <UserBloc,UserState> (
              builder: (context,state) {
                if (state is UserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } if (state is UserLoadedState){
                  List<UserModel>userList = state.users;
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (_,index){
                        return Card(
                          color: Colors.blue,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(userList[index].name,style: TextStyle(fontSize: 25,color: Colors.white),),
                            subtitle: Text(userList[index].username,style: TextStyle(fontSize: 25,color: Colors.white),),
                            trailing: CircleAvatar(
                              backgroundImage:NetworkImage(userList[index].profile_image) ,
                            ),
                          ),
                        );
                      });

                }




                return Container();
              }

          )
      ),
    );
  }
}