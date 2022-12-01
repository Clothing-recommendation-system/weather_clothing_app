
final outers =[
  [12,17,0],//바람막이
  [13,20,1],//청자켓
  [14,21,2],//야상
  [16,21,3],//트러커자켓
  [16,22,4],//가디건/후드집업
  [17,22,5],//폴리스
  [17,23,6],//야구잠바
  [17,23,7],//항공잠바
  [19,23,8],//가죽자켓
  [20,25,9],//환절기코트
  [21,25,10],//조끼패딩
  [21,27,11],//무스탕
  [23,27,12],//숏패딩
  [25,29,13],//겨울코트
  [26,30,14],//돕바
  [27,30,15],// 롱패딩
];
final tops =[
  [0,2,100],//민소매티셔츠
  [0,5,101],//반소매티셔츠
  [5,10,102],//긴소매티셔츠
  [8,15,103],//셔츠
  [11,18,104],//맨투맨
  [12,20,105],//후드티셔츠
  [14,20,106],//목폴라
  [15,21,107],// 니트/스웨터
  [0,6,108],//여름블라우스
  [5,10,109],//봄가을블라우스
];
final bottoms =[
  [0,5,200],//숏팬츠
  [4,9,201],//트레이닝팬츠
  [5,10,202],//슬랙스
  [6,12,203],//데님팬츠
  [7,15,204],// 코튼팬츠
  [0,5,205],//여름스커트
  [5,10,206],//봄가을스커트
  [7,12,207],//레깅스
  [10,15,208],// 겨울스커트
];
//
List<List<int>> outfitRecommendation(List<int> userConstitution,int degree,
    List<bool> userOuters,List<bool> userTops, List<bool> userBottoms) {
  // [lowerBound, upperBound, clothID]
  // final womanBoth =[
  //   [0,8,0],//여름원피스
  //   [9,15,1],// 봄가을원피스
  //   [18,24,2],// 겨울원피스
  // ];
  final banList=[ //해당 값은 ban 됌 [outer,top,bottom]
    //1000: 모든 옷 포함, -1 : 무시.
    [1000,100,-1],//하의는 상관없이, 민소매는 모든 아우터와 입지 않는다.
    [1000,-1,200], //상의와 상관없이, 숏팬츠는 모든 아우터와 입지 않는다.
  ];
  //
  List<int> aim = [userConstitution[0]-degree,userConstitution[1]-degree];
  List<List<dynamic>> idRecommend= [];
  List<List<int>> indexRecommend= [];
  List<List<int>> existOuter = [];
  List<List<int>> existTop = [];
  List<List<int>> existBottom = [];
  List<int> adequateRecommendation =[7,15];
  double lowerCriteria = 0.0;
  double upperCriteria=100.0;
  double curCriteria=0.0;
  int tryFindCriteria = 0;

  //Will care about one piece at the end
  //organize the clothes existence
  List<int>.generate(userOuters.length, (i) => i).where((i)=>userOuters[i]).forEach((e) {existOuter.add(outers[e]);});
  List<int>.generate(userTops.length, (i) => i).where((i)=>userTops[i]).forEach((e) {existTop.add(tops[e]);});
  List<int>.generate(userBottoms.length, (i) => i).where((i)=>userBottoms[i]).forEach((e) {existBottom.add(bottoms[e]);});

  if (degree<=15){ //Must wear outer
    idRecommend+=outerBruteForce(aim, existOuter,existTop, existBottom );
  }else if (degree<=27){ //Can wear outer or not
    idRecommend+=bruteForce(aim, existTop, existBottom);
    idRecommend+=outerBruteForce(aim, existOuter,existTop, existBottom );
  }else{ //Cannot wear outer
    idRecommend+=bruteForce(aim, existTop, existBottom);
  }

  int lenIDR = idRecommend.length;
  List<bool> havetoBanList = List.generate(lenIDR, (i) => false).toList();
  //먼저 ban list 에 있는거 없나 점검
  for (var banIndex=0;banIndex<banList.length;banIndex++){
    for (var idRIndex=0;idRIndex<lenIDR;idRIndex++){
      bool haveToBan = true;
      for (var oub = 0 ; oub<3 ; oub++){
        if (banList[banIndex][oub]==-1){}
        else if(banList[banIndex][oub]==1000){if(idRecommend[idRIndex][oub] ==-1) {haveToBan = haveToBan&false;} }
        else{if(banList[banIndex][oub]!=idRecommend[idRIndex][oub]){haveToBan=haveToBan&false;}}
      }
      if (haveToBan){
        havetoBanList[idRIndex]=true;
      }
    }
  }
  lenIDR = idRecommend.length;
  print(lenIDR);
  for (var i=0;i<lenIDR;i++){
    if(havetoBanList[i]){
      idRecommend[i]=[-1,-1,-1,-1];
    }
  }
  for (var i=0;i<idRecommend.length;i++){
    lenIDR= idRecommend.length;
    if (lenIDR>=i){break;}
    if (idRecommend[i]==[-1,-1,-1,-1]){idRecommend.removeAt(i);}
  }


  lenIDR = idRecommend.length;
  //binary search
  while(tryFindCriteria<=20){
    //set Criteria
    curCriteria = (lowerCriteria+upperCriteria)/2;
    int count=0;
    for (var idRIndex=0;idRIndex<lenIDR;idRIndex++){
      if (idRecommend[idRIndex][3]>=curCriteria){
        count+=1;
      }
    }
    if (count>=adequateRecommendation[0] && count<=adequateRecommendation[1]){
      break; //find adequate curCriteria!
    }else{
      tryFindCriteria+=1;
      if (count>adequateRecommendation[1]){ //too many.. have to search larger criteria
        lowerCriteria=curCriteria;
      }else{ //too less.. have to search smaller criteria
        upperCriteria=curCriteria;
      }
    }
  }
  print('$tryFindCriteria 회 탐색, 유사도: $curCriteria%');
  //Translate ID to index
  int indexRecommendSize = -1;
  for (var t =0; t<idRecommend.length;t++){
    if(idRecommend[t][3]>curCriteria){
      indexRecommend.add([-1,-1,-1]);
      indexRecommendSize+=1;
      List<int> id = [
        idRecommend[t][0]==-1?-1:existOuter[idRecommend[t][0]][2],
        idRecommend[t][1]=existTop[idRecommend[t][1]][2],
        idRecommend[t][2]=existBottom[idRecommend[t][2]][2]];
      for(var idIndex=0;idIndex<3;idIndex++) {
        if (id[idIndex] != -1) {
          indexRecommend[indexRecommendSize][id[idIndex] ~/ 100] = id[idIndex] % 100;
        }else{indexRecommend[indexRecommendSize][idIndex]=-1;}
      }
    }
  }

  return indexRecommend;
}

List<List<dynamic>> bruteForce(aim,List<List<int>> topField, List<List<int>> bottomField){
  List<List<dynamic>> recommend = [];
  double getSimilarity;
  for (var topIndex=0;topIndex<topField.length;topIndex++){
    for(var bottomIndex=0;bottomIndex<bottomField.length;bottomIndex++){
      getSimilarity = suitable(aim, x: topField[topIndex], y: bottomField[bottomIndex]);
      if (getSimilarity!=0) {
        recommend.add([-1,topIndex, bottomIndex,getSimilarity]);
      }
    }
  }
  return recommend;
}

List<List<dynamic>> outerBruteForce(List<int> aim,List<List<int>> outerField,List<List<int>> topField,List<List<int>> bottomField ){
  List<List<dynamic>> recommend = [];
  double getSimilarity;
  for (var topIndex=0;topIndex<topField.length;topIndex++){
    for(var bottomIndex=0;bottomIndex<bottomField.length;bottomIndex++){
      for(var outerIndex=0;outerIndex<outerField.length;outerIndex++) {
        if(topField[topIndex][2] !=100 &&topField[topIndex][2] !=101 && bottomField[bottomIndex][2] !=200){ //민소매 : 100, 숏팬츠 : 101,반소매: 200
          getSimilarity = suitable(aim, x: topField[topIndex], y: bottomField[bottomIndex],z:outerField[outerIndex]);
          if (getSimilarity!=0) {
            recommend.add([outerIndex,topIndex, bottomIndex,getSimilarity]);
        }
        }
      }
    }
  }
  return recommend;
}


double suitable( List<int> aim,{List<int>? x,List<int>? y,List<int>? z}){ //cloth이 aim에 포함되는지 출력
  List<int> clothes = [0,0];
  int overlapRange=0;
  //Criteria 는 옷의 전체 range
   //if it is not one piece
  if (x !=null){clothes[0]+=x[0];clothes[1]+=x[1];}
  if (y !=null){clothes[0]+=y[0];clothes[1]+=y[1];}
  if (z !=null){clothes[0]+=z[0];clothes[1]+=z[1];}

  if (clothes[1]>=aim[0] && clothes[0]<=aim[1]){
    overlapRange = ((clothes[1]<aim[1]?clothes[1]:aim[1])-(clothes[0]>aim[0]?clothes[0]:aim[0])+1);
    return (200*overlapRange/(clothes[1]-clothes[0]+aim[1]-aim[0]+2)); //suitable
  }
  return 0; //not suitable
}

List<int> adjustConstitution(feedback,userConstitution,userOutfit,todayWeather) { //feedback : 0~4 int, userConstitution : [a,b] 알고리즘 수정필요******
  //feedback =>  [so cold, cold, normal, hot, so hot]
  int maxSize=7;
  if(feedback==2){
    return userConstitution;    //default [30,35]
  }
  else {
    userOutfit[0]+=todayWeather;
    userOutfit[1]+=todayWeather;
    if (feedback>3){ //더울 경우
      if(userConstitution[1]<userOutfit[1]){
        userConstitution[1]-=1;
        userConstitution[0]-=1;
      }else{
        userConstitution[1]=userOutfit[0]+maxSize;
      }

    } else { //추울 경우
      if(userConstitution[0]>userOutfit[0]){

      }else{

      }
    }
  }
  return userConstitution; //return type: [a,b]
}



