import 'package:aulao_bloc/app/home/blocs/search_cep_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/search_cep_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "cep"),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SearchCepBloc>().add(textController.text);
              },
              child: Text(
                "Pesquisar",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // StreamBuilder<Map>( Bloc
            //   stream: searchCepBloc.cepResult,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Text(
            //         "${snapshot.error}",
            //         style: TextStyle(color: Colors.red),
            //       );
            //     }
            //     if (!snapshot.hasData) {
            //       return Container();
            //     }
            //     return Text(
            //       "Cidade: ${snapshot.data!['localidade']}",
            //     );
            //   },
            // ),

            // StreamBuilder<SearchCepState>( //pode ser usado no flutter_bloc ou rxdart
            //   stream: searchCepBloc.stream,
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return Container();
            //     }
            //     var state = snapshot.data!;
            //     if (state is SearchCepError) {
            //       return Text(
            //         "${state.message}",
            //         style: TextStyle(color: Colors.red),
            //       );
            //     }
            //     if (state is SearchCepLoading) {
            //       return Expanded(
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //     state = state as SearchCepSuccess;
            //     return Text(
            //         "Cidade: ${state.data['localidade']}/${state.data['uf']}");
            //   },
            // ),

            BlocBuilder<SearchCepBloc, SearchCepState>(
              builder: (context, state) {
                if (state is SearchCepLoading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is SearchCepError) {
                  return Text(
                    "${state.message}",
                    style: TextStyle(color: Colors.red),
                  );
                }
                state = state as SearchCepSuccess;
                if (state.data.isEmpty) {
                  return Container();
                }
                return Text(
                    "Cidade: ${state.data['localidade']}/${state.data['uf']}");
              },
            )
          ],
        ),
      ),
    );
  }
}
