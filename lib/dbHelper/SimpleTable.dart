import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'theData.dart';

class SimpleTablePage extends StatefulWidget {
  const SimpleTablePage({
    Key? key,
    //required this.user,
  }) : super(key: key);
  //final User user;

  @override
  State<SimpleTablePage> createState() => _SimpleTablePageState();
}

class _SimpleTablePageState extends State<SimpleTablePage> {
  @override
  void initState() {
    //widget.user.initData(100);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      // Scaffold(
      // appBar: AppBar(title: const Text('Simple Table')),
      // body:
      HorizontalDataTable(
        leftHandSideColumnWidth: 300,
        rightHandSideColumnWidth: 100,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        //isFixedFooter: true,
        //footerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: myRecords.recordsList.length,

        rowSeparatorWidget: const Divider(
          color: Colors.black38,
          height: 1.0,
          thickness: 1.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),

    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Name', 100),
      _getTitleItemWidget('Age', 100),
      // _getTitleItemWidget('Phone', 200),
      // _getTitleItemWidget('Register', 100),
      // _getTitleItemWidget('Termination', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
     // child: Text(widget.user.userInfo[index].name),
      child: Text(myRecords.recordsList[index].Name),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,

          child:
              // Icon(
              //     widget.user.userInfo[index].status=='true'
              //         ? Icons.notifications_off
              //         : Icons.notifications_active,
              //     color: widget.user.userInfo[index].status=='true'
              //         ? Colors.red
              //         : Colors.green),
              // Text(widget.user.userInfo[index].status=='true' ? 'Disabled' : 'Active')


              Text(myRecords.recordsList[index].Age.toString())

          ),

        // Container(
        //   width: 200,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        //   child: Text(widget.user.userInfo[index].phone),
        // ),
        // Container(
        //   width: 100,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        //   child: Text(widget.user.userInfo[index].registerDate),
        // ),
        // Container(
        //   width: 200,
        //   height: 52,
        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        //   alignment: Alignment.centerLeft,
        //   child: Text(widget.user.userInfo[index].terminationDate),
        // ),
      ],
    );
  }
}