import 'package:flutter/material.dart';
import 'package:news/api/models.dart';
import 'package:news/api/parsed.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Post? _post;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    _post = await API_Manager().getNews();
    if (_post != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter News App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: _post?.articles?.length,
            itemBuilder: (context, index) {
              var article = _post?.articles?[index];
              return Container(
                height: 100,
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          article?.urlToImage ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article?.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            article?.description ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
