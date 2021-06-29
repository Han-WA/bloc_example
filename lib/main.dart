import 'package:counter_app/counter_cubit.dart';
import 'package:counter_app/networkloading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<NetworkloadingCubit>(
          create: (context) => NetworkloadingCubit(),
        ),
      ],
      child: MaterialApp(
        title: "Flutter Cubit",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CUBIT"),
      ),
      body: Column(
        children: [
          Center(
            child: BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(
                  "The value is $state",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                label: Text(
                  "Plus",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                },
                icon: Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                label: Text(
                  "Minus",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NetworkloadingCubit>(context).loading();
                },
                child: Text("Loading"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NetworkloadingCubit>(context).success();
                },
                child: Text("Scccess"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NetworkloadingCubit>(context).fail();
                },
                child: Text("Fail"),
              ),
              SizedBox(width: 10),
            ],
          ),
          BlocBuilder<NetworkloadingCubit, NetworkloadingState>(
              builder: (context, state) {
            if (state is NetworkSuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                      state.data[index],
                    ),
                  ),
                ),
              );
            } else if (state is NetworkFailure) {
              return Text(state.error);
            } else {
              return CircularProgressIndicator();
            }
          }),
        ],
      ),
    );
  }
}
