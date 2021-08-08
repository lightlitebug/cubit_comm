import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/color/color_cubit.dart';
import 'cubit/counter/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            colorCubit: BlocProvider.of<ColorCubit>(context),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Cubit Comm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Change Color'),
              onPressed: () {
                context.read<ColorCubit>().changeColor();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '${context.watch<CounterCubit>().state.counter}',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Incrment Counter'),
              onPressed: () {
                context.read<CounterCubit>().changeCounter();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
