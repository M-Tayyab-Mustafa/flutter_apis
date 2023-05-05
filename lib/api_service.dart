import 'package:flutter_apis/api_services.dart';
import 'models/post.dart';

class APIService extends ApiServices {
  @override
  String get apiUrl => '/posts';
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPost() async {
    List lsitOfPostMap = await get();
    return lsitOfPostMap.map((map) => Post.fromMap(map)).toList();
  }

  Future<bool> insertPost() async {
    bool response = await post(
        map: Post(
                userId: 10,
                id: 101,
                title: 'Post Checking',
                body: 'This post is created by me to check post method')
            .toMap());
    return response;
  }
}
