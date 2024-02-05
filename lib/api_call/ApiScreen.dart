import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'AdhanDataModel.dart';

class ApiScreen extends StatefulWidget {
  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  late Adhan _adhan;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimings();
  }

  Future<void> _fetchPrayerTimings() async {
    try {
      final response = await apiService.getPrayerTimings(2017, 4, 51.508515, -0.1254872);
      setState(() {
        _adhan = response;
      });
    } catch (e) {
      print('Error: $e');
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
                'Prayer Timings for ${_adhan.data[0].date.readable}',
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
                  color: Colors.yellow[200], // Yellow card color
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
        child: CircularProgressIndicator(),
      ),
    );
  }
}
