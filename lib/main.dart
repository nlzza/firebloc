import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'state/auth_bloc.dart';
import 'state/counter_bloc.dart';
import 'state/counter_cubit.dart';
import 'state/users_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterBloc(),
        ),
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(
          create: (_) => UsersCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    final usersCubit = context.watch<UsersCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FireBloc'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: false
          ? ListTile(
              title: Text(
                authBloc.state.status.toString(),
              ),
              subtitle: Text(
                authBloc.state.user?.name ?? 'None',
              ),
              trailing: Text(
                authBloc.state.user?.age.toString() ?? 'None',
              ),
            )
          : ListView.builder(
              itemCount: usersCubit.state.length,
              itemBuilder: (_, i) {
                final user = usersCubit.state[i];

                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.uid),
                  trailing: Text(user.age.toString()),
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FloatingActionButton(
          //   onPressed: () {},
          //   tooltip: 'Decrement',
          //   child: const Icon(Icons.west),
          // ),
          // const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              authBloc.add(
                AuthFetchEvent(uid: '123'),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
