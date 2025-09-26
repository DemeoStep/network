import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/domain/entity/user_entity.dart';
import 'package:network/domain/repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError || !snapshot.hasData) {
              Text('Error: ${snapshot.error}');
            }

            final data = snapshot.data;

            return ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                final user = data?[index];
                return ListTile(
                  title: Text(user?.name ?? 'No Name'),
                  subtitle: Text(user?.email ?? 'No Email'),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<UserEntity>> get fetchUsers async {
    final result = await GetIt.I.get<UserRepository>().getUsers();
    if (result.isOk) {
      return result.data ?? [];
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(hours: 1),
            showCloseIcon: true,
            content: Text('Error: ${result.error}'),
          ),
        );
      }
      return [];
    }
  }
}
