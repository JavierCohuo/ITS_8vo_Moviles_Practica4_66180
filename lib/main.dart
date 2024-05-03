import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/words': (context) => const WordsScreen(),
        '/nouns': (context) => const NounsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/words');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5,
              ),
              child: const Text('Words'),
            ),
            const SizedBox(height: 30), // Separador
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nouns');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5,
              ),
              child: const Text('Nouns'),
            ),
          ],
        ),
      ),
    );
  }
}

class WordsScreen extends StatelessWidget {
  const WordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Words")),
      body: RandomWords(),
    );
  }
}

class NounsScreen extends StatelessWidget {
  const NounsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouns")),
      body: RandomNouns(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final ScrollController _scrollController = ScrollController();
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _loadMore();
    }
  }

  void _loadMore() {
    setState(() {
      _suggestions.addAll(generateWordPairs().take(20));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _suggestions.length * 2,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) return const Divider();
        final int index = i ~/ 2;
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomNouns extends StatefulWidget {
  const RandomNouns({Key? key}) : super(key: key);

  @override
  _RandomNounsState createState() => _RandomNounsState();
}

class _RandomNounsState extends State<RandomNouns> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _nouns = <String>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      _loadMore();
    }
  }

  void _loadMore() {
    setState(() {
      _nouns.addAll(generateWordPairs().take(20).map((pair) => pair.first));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: _nouns.length * 2,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) return const Divider();
        final int index = i ~/ 2;
        return ListTile(
          title: Text(
            _nouns[index],
            style: _biggerFont,
          ),
        );
      },
    );
  }
}
