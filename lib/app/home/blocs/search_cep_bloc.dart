import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'search_cep_state.dart';

// Bloc, só tem um return
/*class SearchCepBloc {
  final _streamController = StreamController<String>.broadcast();
  Sink<String> get searchCep => _streamController.sink;
  Stream<Map> get cepResult => _streamController.stream.asyncMap(_seachCep);

  Future<Map> _seachCep(String cep) async {
    final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
    return response.data;
  }

  void dispose() {
    _streamController.close();
  }
}
*/

// rxdart, operador yield que seria o return, porem pode retornar VARIOS yield. PS: ele retorna a STREAM nao uma Future
// class SearchCepBloc {
//   final _streamController = StreamController<String>.broadcast();
//   Sink<String> get searchCep => _streamController.sink;
//   Stream<SearchCepState> get cepResult =>
//       _streamController.stream.switchMap(_seachCep);

//   Stream<SearchCepState> _seachCep(String cep) async* {
//     yield SearchCepLoading();
//     try {
//       final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
//       yield SearchCepSuccess(response.data);
//     } catch (e) {
//       yield SearchCepError("Erro na pesquisa");
//     }
//   }

//   void dispose() {
//     _streamController.close();
//   }
// }

// flutter_bloc
class SearchCepBloc extends Bloc<String, SearchCepState> {
  SearchCepBloc(this.dio) : super(SearchCepSuccess({}));
  final Dio dio;

  @override
  Stream<SearchCepState> mapEventToState(String cep) async* {
    yield SearchCepLoading();
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
      yield SearchCepSuccess(response.data);
    } catch (e) {
      yield SearchCepError("Erro na pesquisa");
    }
  }
}
