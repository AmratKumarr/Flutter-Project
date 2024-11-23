import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Data Fetching and Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DataListScreen(),
    );
  }
}

class DataListScreen extends StatefulWidget {
  const DataListScreen({super.key});

  @override
  _DataListScreenState createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  List<dynamic> _data = []; // List to hold fetched data
  List<dynamic> _filteredData = []; // List to hold filtered data
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _searchController.addListener(_filterData);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterData);
    _searchController.dispose();
    super.dispose();
  }

  // Fetch data from the API
  Future<void> _fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = json.decode(response.body);
      setState(() {
        _data = fetchedData;
        _filteredData = _data; // Initially, show all data
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Filter data based on search input
  void _filterData() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _data
          .where((item) => item['title'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data Fetching and Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            // ListView to display data
            Expanded(
              child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  var item = _filteredData[index];
                  return ListTile(
                    title: Text(item['title']),
                    subtitle: Text(item['body']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
