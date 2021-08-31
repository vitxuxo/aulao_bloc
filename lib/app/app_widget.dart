import 'package:aulao_bloc/app/home/blocs/search_cep_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // os Blocs
        Provider(create: (_) => Dio()),
        BlocProvider(
          create: (context) => SearchCepBloc(context.read()),
        ),
      ],
      child: MaterialApp(
        title: 'Home',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(),
      ),
    );
  }
}
