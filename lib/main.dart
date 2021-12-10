import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? header, subscribeCount, img;

  void scrapData() async {
    const url = 'https://habr.com/ru/all/';
    var response = await Chaleno().load(url);

    header = response?.querySelector('div.tm-section-name > h1').text;

    subscribeCount = response
        ?.querySelectorAll('div.tm-article-snippet > h2 > a > span')
        .map((e) => ("${e.text}\n\n"))
        .toString();

    img = response
        ?.querySelector(
            'div.tm-article-body.tm-article-snippet__lead > div.tm-article-snippet__cover.tm-article-snippet__cover_cover > img')
        .src;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    scrapData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 20),
            child: header == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          '$img',
                          width: 120,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '$header',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '$subscribeCount',
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
