import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quote_quill/networks/models/quotes_req_model.dart';
import 'package:quote_quill/networks/repo/quotes_repo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<QuotesReqModel?> featchData() async {
    final QuotesRepo quotesRepo = QuotesRepo();
    final response = await quotesRepo.quotesReq();
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    featchData();
    return const Scaffold();
  }
}
