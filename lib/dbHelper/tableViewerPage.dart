import 'package:flutter/material.dart';

import 'SimpleTable.dart';

class tableViewerPage extends StatefulWidget {
   tableViewerPage({super.key});

  @override
  State<tableViewerPage> createState() => _tableViewerPageState();
}

class _tableViewerPageState extends State<tableViewerPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Table Viewer'),),

      body: SimpleTablePage()

    );
  }
}
