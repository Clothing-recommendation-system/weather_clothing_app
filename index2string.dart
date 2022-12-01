//made to test
List<List<String>> clothesMap(List<List<int>> intList){
  print(intList);
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



  //추후에는 provider 로 가져올 것.

  List<List<String>> toStr = [];
  for(var i=0;i<intList.length;i++){
    toStr.add([]);
    for(var j=0;j<3;j++){
      if (intList[i][j] !=-1){
        toStr[i].add(clothesName[j][intList[i][j]]);
      }
    }
  }
  return toStr;
}