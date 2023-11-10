import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:quote_quill/networks/models/quotes_req_model.dart';

import 'package:quote_quill/networks/repo/quotes_repo.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

part 'package:quote_quill/featuers/home/home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(_Initial()) {
    on<_GetData>((event, emit) async {
      emit(_Loading());
      final QuotesRepo quotesRepo = QuotesRepo();
      final response = await quotesRepo.quotesReq();

      if (response != null && response.error == null) {
        emit(_Sucess(response.quotesList));
      } else {
        emit(_Failed(error: response?.error ?? "unknown error"));
      }
    });
  }
}
