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

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
        child: FutureBuilder(
          future: featchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("loading"),
              );
            }

            if (snapshot.hasData) {
              final quotesDetails = snapshot.data;
              if (quotesDetails!.error != null) {
                return Center(
                  child: Text('Error: ${quotesDetails.error}'),
                );
              } else {
                final quotesDetails = snapshot.data;

                print(quotesDetails);
                return ListView.builder(
                  itemCount: quotesDetails!.q?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 100,
                      color: Colors.blueAccent[200],
                      child: Column(children: [
                        Text(
                            "You don't need a weatherman to know which way the wind blows."),
                        Text("Bob Dylan"),
                      ]),
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    ));
  }
}
