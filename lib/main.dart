import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_quill/featuers/home/bloc/home_bloc.dart';

//testing 1
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider(create: (_) => HomeBloc(), child: const MyHomePage()),
    );
  }
}
