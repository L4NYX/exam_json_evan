import 'package:flutter/material.dart';
import 'package:flutter_exam_2/models/post.dart';

class PostPageStateful extends StatefulWidget {
  const PostPageStateful({super.key});

  @override
  State<PostPageStateful> createState() => _PostPageStatefulState();
}

class _PostPageStatefulState extends State<PostPageStateful> {
  List<PostResult> postResults = [];

  void fetchPosts() async {
    final posts = await PostResult.fetchPosts();
    setState(() {
      postResults = posts;
    });
  }

  void addPost() {
    PostResult.connectToAPI(
      'Akun baru',
      'contohemail@email.com',
      'Contoh komentar',
    ).then((value) {
      setState(() {
        postResults.add(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam JSON dan rest API Evan post"),
      ),
      body: ListView.builder(
        itemCount: postResults.length,
        itemBuilder: (context, index) {
          final post = postResults[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(post.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.email),
                  Text(post.body),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPost,
        child: Icon(Icons.add),
      ),
    );
  }
}
