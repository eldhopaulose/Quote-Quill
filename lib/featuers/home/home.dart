import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quote_quill/networks/models/quotes_req_model.dart';
import 'package:quote_quill/networks/repo/quotes_repo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<QuotesReqModel?> fetchData() async {
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
          child: FutureBuilder<QuotesReqModel?>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("Loading"),
                );
              }

              if (snapshot.hasData) {
                final quotesDetails = snapshot.data;
                if (quotesDetails!.error != null) {
                  print("Error: ${quotesDetails.error}");
                  return Center(
                    child: Text('Error: ${quotesDetails.error}'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: quotesDetails.q?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Quote: ${quotesDetails.q}"),
                                SizedBox(),
                                Text("Author: ${quotesDetails.a}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
      ),
    );
  }
}
