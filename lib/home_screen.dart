import 'package:flutter/material.dart';
import 'package:flutter_apis/api_service.dart';
import 'package:flutter_apis/models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Post>>? futureOfPosts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: futureOfPosts,
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Click Button To Fetch Data');
            } else if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Post post = snapshot.data![index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            post.id.toString(),
                          ),
                        ),
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        trailing: Text(post.userId.toString()),
                      );
                    });
              } else {
                throw Exception('Some Thing Went Wrong');
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          futureOfPosts = APIService().fetchPost();
          setState(() {});
        },
        tooltip: 'Load Data',
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }
}
