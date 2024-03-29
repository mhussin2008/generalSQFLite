import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'theData.dart';

class SimpleTablePage extends StatelessWidget {
   SimpleTablePage({
    Key? key,
    //required this.user,
  }) : super(key: key);
  //final User user;

  var _tstyle=TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {

    return

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
      _getTitleItemWidget('Name', 300),
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
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
     // child: Text(widget.user.userInfo[index].name),
      child: Text(myRecords.recordsList[index].Name,style: _tstyle,),
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


              Text(myRecords.recordsList[index].Age.toString(),style: _tstyle,)

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