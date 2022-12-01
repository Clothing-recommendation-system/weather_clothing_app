import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teamproject/feedbackPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String pass = '';
  int currentPageIndex = 2;
  bool _switch1 = true;
  bool _switch2 = true;
  RangeValues _currentRangeValues = const RangeValues(0, 20);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topRight,
            child: const Text(
              'sht06025 님   ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              height:0.8,
              width:500.0,
              color:Colors.black
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return feedbackPage();
                    });
                  },
                  child: const Text('   피드백 설정'),
                ),
              ],
            ),
          ),]
    ),
    );
  }
}