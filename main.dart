import 'package:flutter/material.dart';
import 'package:teamproject/OutfitRecommender.dart';
import 'package:teamproject/index2string.dart';
import 'SettingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // home: const SettingsPage(title: "Setting page"),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {

  // final womanBoth =[
  //   true,//여름원피스
  //   true,// 봄가을원피스
  //   true,// 겨울원피스
  // ];
  List<List<String>> clothesName = [
    ['바람막이', '청자켓','야상','트러커자켓','가디건',
      '플리스','야구잠바','항공잠바','가죽자켓','환절기코트',
      '조끼패딩', '무스탕','숏패딩','겨울코트','돕바',
      '롱패딩'],
    ['민소매티','반소매티','긴소매티','셔츠','맨투맨',
      '후드티셔츠','목폴라','니트','여름블라우스','봄가을블라우스'],
    ['숏팬츠','트레이닝팬츠','슬랙스','데님팬츠','코튼팬츠'
      ,'여름스커트','봄가을스커트','레깅스','겨울스커트'],
  ];
  var outers =[
    true,//바람막이
    true,//청자켓
    true,//야상
    true,//트러커자켓
    true,//가디건/후드집업
    true,//폴리스
    true,//야구잠바
    true,//항공잠바
    true,//가죽자켓
    true,//환절기코트
    true,//조끼패딩
    true,//무스탕
    true,//숏패딩
    true,//겨울코트
    true,//돕바
    true,//롱패딩
  ];
  var tops =[
    true,//민소매티셔츠
    true,//반소매티셔츠
    true,//긴소매티셔츠
    true,//셔츠
    true,//맨투맨
    true,//후드티셔츠
    true,//목폴라
    true,// 니트/스웨터
    true,//여름블라우스
    true,//봄가을블라우스
  ];
  var bottoms =[
    true,//숏팬츠
    true,//트레이닝팬츠
    true,//슬랙스
    true,//데님팬츠
    true,// 코튼팬츠
    true,//여름스커트
    true,//봄가을스커트
    true,//레깅스
    true,// 겨울스커트
  ];

  bool userGender= true; // true: woman, false:man
  List<int> userConstitution= [12,24];
  List<List<String>> outfitOutput =[];
  int degree = 0;
  int feedback = 2;
  List<int> todayOutfit =[-1,5,6];

  final outersIndex = List.generate(16, (i) => i).toList();
  final topsIndex = List.generate(10, (i) => i).toList();
  final bottomsIndex = List.generate(9, (i) => i).toList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Page'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column( //Outers
                      children:
                       outersIndex.map((i)=>
                            Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                    child: Text(clothesName[0][i],style: const TextStyle(fontSize: 16),)),
                                Switch(
                                  value: outers[i],
                                  onChanged: (value) {
                                    setState(() {
                                      outers[i] = value;
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                        ),
                              ],
                            )
                       ).toList(),
                    ),
                    Column( //Tops
                      children:
                      topsIndex.map((i)=>
                          Row(
                            children: [
                              SizedBox(width: 60,child: Text(clothesName[1][i],style: const TextStyle(fontSize: 16),)),
                              Switch(
                                value: tops[i],
                                onChanged: (value) {
                                  setState(() {
                                    tops[i] = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          )
                      ).toList(),
                    ),
                    Column( //Bottoms
                      children:
                      bottomsIndex.map((i)=>
                          Row(
                            children: [
                              SizedBox(width: 60,child: Text(clothesName[2][i],style: const TextStyle(fontSize: 16),)),
                              Switch(
                                value: bottoms[i],
                                onChanged: (value) {
                                  setState(() {
                                    bottoms[i] = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          )
                      ).toList(),),
                  ],
                ),
                ElevatedButton(onPressed: (){
                  setState((){
                    //user Cloth information is named parameter. userMantop, userManBottom, userOuter is essential
                    //if userGender is woman.

                    outfitOutput =clothesMap(

                        outfitRecommendation(userConstitution, degree, outers , tops,bottoms)

                    );
                    userConstitution=adjustConstitution(feedback,userConstitution,todayOutfit,degree);

                  });
                }, child: const Text('Convert')),
                Text('degree : $degree',style: const TextStyle(fontSize: 16),),
                Text('feedback : $feedback',style: const TextStyle(fontSize: 16),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){setState(() {feedback=0;});}, child: const Text("so cold")),
                    ElevatedButton(onPressed: (){setState(() {feedback=1;});}, child: const Text("cold")),
                    ElevatedButton(onPressed: (){setState(() {feedback=2;});}, child: const Text("good")),
                    ElevatedButton(onPressed: (){setState(() {feedback=3;});}, child: const Text("hot")),
                    ElevatedButton(onPressed: (){setState(() {feedback=4;});}, child: const Text("so hot"))
                  ]
                ),
                Text('userConstitution : $userConstitution',style: const TextStyle(fontSize: 16),),
                Text('Recommend length : ${outfitOutput.length}',style: const TextStyle(fontSize: 16),),
                Text('Recommendation : $outfitOutput',style: const TextStyle(fontSize: 16),),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

