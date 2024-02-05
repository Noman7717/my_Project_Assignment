import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDemoPage extends StatefulWidget {
  @override
  _ApiDemoPageState createState() => _ApiDemoPageState();
}

class _ApiDemoPageState extends State<ApiDemoPage> {
  bool isLoading = true;
  Map<String, dynamic> responseData = {};
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/calendar/2024/4?latitude=51.508515&longitude=-0.1254872&method=2'));
      if (response.statusCode == 200) {
        setState(() {
          responseData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Demo Page'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : error.isNotEmpty
            ? Text(error)
            : Text('Data Loaded: ${responseData.toString()}'),
      ),
    );
  }
}
