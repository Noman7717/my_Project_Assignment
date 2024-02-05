import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'AdhanDataModel.dart';

class ApiScreen extends StatefulWidget {
  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  late Adhan _adhan = Adhan(
    code: 0,
    status: '',
    data: [],
  ); // Initialize _adhan with default values
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimings();
  }

  Future<void> _fetchPrayerTimings() async {
    try {
      final response = await apiService.getPrayerTimings(2024, 2, 51.508515, -0.1254872);
      setState(() {
        _adhan = response;
      });
    } catch (e) {
      print('Error: $e');
      // Display a SnackBar or AlertDialog to inform the user about the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch data. Please check your internet connection.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('Prayer Timings'),
        backgroundColor: Colors.yellow[600],
      ),
      body: _adhan != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.yellow[400],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Prayer Timings for ${_adhan.data.isNotEmpty ? _adhan.data[0].date.readable : ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _adhan.data.length,
              itemBuilder: (context, index) {
                final prayerTimings = _adhan.data[index].timings;

                return Card(
                  color: Colors.yellow[200],
                  child: ListTile(
                    title: Text(_adhan.data[index].date.readable),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fajr: ${prayerTimings.fajr}'),
                        Text('Dhuhr: ${prayerTimings.dhuhr}'),
                        Text('Asr: ${prayerTimings.asr}'),
                        Text('Maghrib: ${prayerTimings.maghrib}'),
                        Text('Isha: ${prayerTimings.isha}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
          : Center(
        child: Text(
          'Failed to fetch data. Please try again later.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
