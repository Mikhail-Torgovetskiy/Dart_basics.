import './skillboxPractice_2_lib.dart';

void main() {
  print('-------- ======= 1 ======== --------');
  var dc = DelimetersCalculator();
  List<int> factors = dc.getFactors(24);
  print('factors=$factors');

  int gcd = dc.getGreatestCommonDivisor(24,60);
  print('GCD=$gcd');

  //int gcdFromStatic = DelimetersCalculator._gcd(24,60); //вызов static-метода
  //print('GCD (вызов static-метода)=$gcdFromStatic');

  int gcdImbedded = 24.gcd(60);
  print('(А также: НОД (встроенный метод)=$gcdImbedded)');

  int lcm = dc.getLeastCommonMultiple(126,70);
  print('LCM=$lcm');

  print(''); print('');
  print('-------- ======= 2 ======== --------');
  var nst = NumberSystemTranslator();

  String binaryFromDecimal = nst.getDecimalToBinary(157);
  print('binaryFromDecimal=$binaryFromDecimal');

  String binaryFromDecimalImbedded = 157.toRadixString(2);
  print('(А также встроенным методом: $binaryFromDecimalImbedded)');

  int decimalFromBinary = nst.getBinaryToDecimal(binaryFromDecimal);
  print('decimalFromBinary=$decimalFromBinary');

  int decimalFromBinaryImbedded = int.parse(binaryFromDecimal, radix: 2);
  print('А также встроенным методом: $decimalFromBinaryImbedded');

  print('');
  print('-------- ======== 3 ======== --------');
  var nft = NumbersFromText();
  String words = 'миллион   пять пять   тысяча   один точка два три запятая четыре пять и кавычки шесть семь десять сорок пятьдесят';
  Map<String, int> samplesRus = {
    'ноль'  :0,
    'один'  :1,
    'два'   :2,
    'три'   :3,
    'четыре':4,
    'пять'  :5,
    'шесть' :6,
    'семь'  :7,
    'восемь':8,
    'девять':9,
    'десять':10,
    'одиннадцать' :11,
    'двенадцать'  :12,
    'тринадцать'  :13,
    'четырнадцать':14,
    'пятнадцать'  :15,
    'шестнадцать' :16,
    'семнадцать'  :17,
    'восемнадцать':18,
    'девятнадцать':19,
    'двадцать'    :20,
    'тридцать'    :30,
    'сорок'       :40,
    'пятьдесят'   :50,
    'шестьдесят'  :60,
    'семьдесят'   :70,
    'восемьдесят' :80,
    'девяносто'   :90,
    'сто'      :100,
    'двести'   :200,
    'триста'   :300,
    'четыреста':400,
    'пятьсот'  :500,
    'шестьсот' :600,
    'семьсот'  :700,
    'восемьсот':800,
    'девятьсот':900,
    'тысяча'   :1000,
    'миллион'  :1000000,
    'миллиард' :1000000000
  };
  String separator = ' '; //разделитель - пробел
  print(nft.getNumbersFromWordString(words, samplesRus, separator, false));

  print('');
  print('-------- =========== 4 ============ ----------');
  List wordList = ['ветчина','колбаса','огурцы','колбаса','чай','колбаса','чай','кетчуп'];
  print(nft.getMapRollupFromList(wordList));

  print('');
  print('-------- ========== 5 =========== -------------');
  Map<String, int> samplesEng = {
    'zero' : 0,
    'one'  : 1,
    'two'  : 2,
    'three': 3,
    'four' : 4,
    'five' : 5,
    'six'  : 6,
    'seven': 7,
    'eight': 8,
    'nine' : 9
  };

  //коллекция строк:
  List<String> stringsOfWordsCollection = [
    'our, phone, is, three, two, two, two, two, three, oh, three, two',
    'one, two, three, cat, dog',
    'potato, cucumber, zero, zero, tomato',
    'cat, dog, lion, zebra, cangaroo',
    'orange, lemon, three, nine, nine'
  ];
  separator = ',';
  print(nft.getDigitsWithoutDoubles(stringsOfWordsCollection, samplesEng, separator, true));

  print('');
  print('-------- ========== 6 ============ -------------');
  Point p1 = Point(-1,2,-3);
  Point p2 = Point(1,1,-5);

  double distance = p1.distanceTo(p2);
  print('distance=$distance');

  print('');
  print('-------- ========== 7 ============ -------------');
  double number     = 125;  //подкоренное число
  int    rootDegree = 3;    //степень корня
  double epsilon    = 0.01; //точность вычислений

  var rootOfNumber = number.getRoot(rootDegree, epsilon);
  print('rootOfNumber=$rootOfNumber');


  print('');
  print('-------- ========== 8 ============ -------------');

  User vasia = User('Vasia','KorobkinVM@mail.ru');
  User petia = User('Petia','SemionoffPT@yandex.ru');
  User admin = User('admin','BezfamilniyHH@rambler.ru');

  var um = UserManager();
  um.addUser(vasia);
  um.addUser(petia);
  um.addUser(admin);

  um.removeUser(vasia);

  um.userMailOutput();

  print('');
  print('-------- =========== 10 ============== -------');

  List matrix = [
    [2.0, 1.0, -1.0, 8.0],
    [-3.0, -1.0, 2.0, -11.0],
    [-2.0, 1.0, 2.0, -3.0]
  ];

  // List matrix = [
  //   [4.0, 0.24, -0.08, 8.0],
  //   [0.09, 3.0, -0.15, 9.0],
  //   [0.04, -0.08, 4.0, 20.0]
  // ];

  var solByGauss = Gauss();
  List roots = solByGauss.getRootsWithTriangleTypeMatrix(matrix);
  print('roots=$roots');
}




