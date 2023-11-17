part of 'package:quote_quill/featuers/home/bloc/home_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late HomeBloc bloc;
  @override
  void initState() {
    super.initState();
    // Initialize your bloc or handle this initialization appropriately
    bloc = context.read<HomeBloc>();
   bloc.add(const _GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is _Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is _Sucess) {
                  final detailsList = state.quotesList;
                  return ListView.builder(
                    itemCount: state.quotesList.length,
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
                              Text("Quote: ${detailsList[index].q}"),
                              Text("Author: ${detailsList[index].a}"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is _Failed) {
                  return Center(child: Text(state.error));
                } else {
                  return Center(child: const Text("Unhandled state"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
