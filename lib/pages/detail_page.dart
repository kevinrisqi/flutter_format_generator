import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.data});

  Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Excel'),
      ),
      body: ListView.builder(
        itemCount: data['name'].length,
        itemBuilder: (context, index) {
          var name = data['name'][index];
          var link = data['link'][index];
          return ListTile(
            leading: Text('$name'),
            subtitle: Text('$link'),
          );
        },
      ),
    );
  }
}
