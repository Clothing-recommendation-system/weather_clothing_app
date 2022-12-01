import 'package:flutter/material.dart';

class feedbackPage extends StatefulWidget {
  const feedbackPage({Key? key}) : super(key: key);

  @override
  State<feedbackPage> createState() => _feedbackPageState();
}

class _feedbackPageState extends State<feedbackPage> {

  List<List<String>> clothesName = [
    ['안입음','바람막이', '청자켓','야상','트러커자켓','가디건',
      '플리스','야구잠바','항공잠바','가죽자켓','환절기코트',
      '조끼패딩', '무스탕','숏패딩','겨울코트','돕바',
      '롱패딩'],
    ['민소매티','반소매티','긴소매티','셔츠','맨투맨',
      '후드티셔츠','목폴라','니트','여름블라우스','봄가을블라우스'],
    ['숏팬츠','트레이닝팬츠','슬랙스','데님팬츠','코튼팬츠'
      ,'여름스커트','봄가을스커트','레깅스','겨울스커트'],
  ];
  double _sliderValue = 2.0;
  final List<String> _valueMap = ["추웠어요","조금 추웠어요","적당했어요","조금 더웠어요","더웠어요"];

  String outerDropdownValue = '안입음';
  String topDropdownValue = '민소매티';
  String bottomDropdownValue = '숏팬츠';
  // int outerIndex = clothesName[0].indexOf(outerDropdownValue)-1;
  // int topIndex = clothesName[1].indexOf(topDropdownValue);
  // int bottomIndex = clothesName[2].indexOf(bottomDropdownValue);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("피드백 설정"),
      titleTextStyle:
      const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),
      actions: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("겉옷 : ",style: TextStyle(fontSize: 16),),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                      isExpanded: true,
                      value: outerDropdownValue,
                      items: clothesName[0].map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          outerDropdownValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("상의 : ",style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                      isExpanded: true,
                      value: topDropdownValue,
                      items: clothesName[1].map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          topDropdownValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("하의 : ",style: TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                      isExpanded: true,
                      value: bottomDropdownValue,
                      items: clothesName[2].map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          bottomDropdownValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('<-추웠어요                          더웠어요->',style: TextStyle(fontSize: 16),),
                ],
              ),
              Slider(
                min: 0.0,
                max: 4.0,
                value: _sliderValue,
                divisions: 4,
                label: _valueMap[_sliderValue.toInt()],
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              ElevatedButton(onPressed: (){
                //이렇게 해도 되나..?
                //Navigator.pop(context,[outerDropdownValue,topDropdownValue,bottomDropdownValue,_sliderValue]);
                Navigator.pop(context);
              }, child: const Text('피드백 적용'))
            ],
          ),
        ),
      ],
      content: const Text("오늘 입은 옷에 대한 피드백을 남겨주세요!"),
    );
  }
}
