import 'dart:math';

class DelimetersCalculator{
  List<int> getFactors(int arg){
    List<int> factors = []; //список для накопления множителей

    double argTemp = arg.toDouble(); //число, у которого осталось найти множители
    int divider = 2;   //число, на которое пытаемся делить

    while (argTemp !=1){
      if (argTemp%divider !=0) {
        divider++;
      }
      else{
        // делим, пока это возможно
        argTemp = argTemp/divider;
        factors.add(divider);
      }
    }
    return factors;
  }

  static int _gcd(int argA, int argB){
    //оформлен в виде static-метода для использования при расчете НОК

    int argATemp = argA;
    int argBTemp = argB;

    while (argBTemp !=0){
      var temp = argBTemp;
      argBTemp = argATemp % temp;
      argATemp = temp;
    }
    return argATemp;
  }

  int getGreatestCommonDivisor(int argA, int argB) {
    int result = _gcd(argA, argB);
    return result;
  }

  int getLeastCommonMultiple(int argA, int argB){
    int result = (argA * argB) ~/ _gcd(argA, argB);

    return result;
  }
}

class NumberSystemTranslator{
  String getDecimalToBinary(int arg){
    String result = '';

    int quotient;  //целая часть частного от деления
    int remainder; //остаток от деления

    int argTemp = arg;

    if ((arg==0) | (arg==1)){
      result = arg.toString();
    }
    else{
      do{
        quotient = argTemp ~/ 2;
        remainder = argTemp.toInt() % 2;
        result = result + remainder.toString();

        argTemp = quotient;
      }while(quotient != 0);
    }
    result = result.split('').reversed.join();
    return result;
  }

  int getBinaryToDecimal(String arg){
    int result = 0;

    int argLength = arg.length;

    int currentBinaryValue; //числовое значение текущей позиции двоичного числа (0 или 1)
    int productTwo;  //произведение двоек для текущей позиции двоичного числа
    int currentValue; //десятичное значение текущей позиции двоичного числа
    for (int i=0; i<argLength; i++){
      currentBinaryValue = int.parse(arg[argLength-1-i]);
      productTwo = 1;
      for (int exponent=1; exponent<=i; exponent++){
        productTwo = productTwo*2;
      }
      currentValue = productTwo*currentBinaryValue;
      result = result + currentValue;
    }
    return result;
  }
}

class NumbersFromText{
  static List<int> _numbersFromWordString(String wordString, Map <String, int> samples, String separator, bool withoutDouble){
    List<int> result = [];

    wordString = '${wordString.trim()} $separator';
    String currentWord = ''; //текущее слово

    int quantityOfIterations = wordString.length-1;
    String letter = ''; //текущая буква

    for (int i=0; i<=quantityOfIterations; i++){
      letter = wordString[i];
      if (letter !=separator){
        currentWord = currentWord + letter;
      }
      else{
        currentWord = currentWord.trim();

        int? entry = samples[currentWord];
        if (entry !=null){
          if (withoutDouble){//заполняем результирующий список без дубликатов
            bool found = result.contains(entry);
            if (!found){
              result.add(entry);
            }
          }
          else{ //не проверяем на дубликаты в списке
            result.add(entry);
          }
        }
        currentWord = '';
      }
    }
    return result;
  }

  List<int> getNumbersFromWordString(String wordString, Map <String, int> samples, String separator, bool withoutDouble){
    return _numbersFromWordString(wordString, samples, separator, withoutDouble);
  }

  Map getMapRollupFromList(List arg){
    Map result = Map();

    int numberOfCurrentWord = 0;
    for(var currentWord in arg){

      if (result.containsKey(currentWord)){
        numberOfCurrentWord = result[currentWord]+1;
      }
      else{
        numberOfCurrentWord = 1;
      }
      result[currentWord] = numberOfCurrentWord;
    }
    return result;
  }

  List getDigitsWithoutDoubles(List<String> stringsCollections, Map<String, int> samples, String separator, bool withoutDouble){
    List result = [];

    for (String line in stringsCollections){
      List<int> lineResult = _numbersFromWordString(line, samples, separator, withoutDouble);
      result.add(lineResult);
    }
    return result;
  }
}

class Point{
  final double x;
  final double y;
  final double z;

  Point(this.x, this.y, this.z);

  factory Point.zero(){
    return Point(0,0,0);
  }

  factory Point.unitVector(){
    return Point(1,1,1);
  }

  double distanceTo(anotherPoint){
    double distance;

    distance = sqrt(pow((this.x-anotherPoint.x),2)+pow((this.y-anotherPoint.y),2)+pow((this.z-anotherPoint.z),2));
    return distance;
  }
}

extension Roots on num {
  static double _pow(double number,int degree){
    double result;

    if (degree==0){
      result = 1;
    }
    else if (degree<0){
      result = 1/_pow(number,-degree);
    }
    else{
      result = 1;
      for(int i=1;i<=degree;i++){
        result = result*number;
      }
    }
    return result;
  }

  double getRoot(int rootDegree, double epsilon){
    double root;

    var number = this;

    if (rootDegree==0){
      root = 1;
      return root;
    }
    double rootTemp = number/rootDegree; //начальное приближение
    bool goOn; //условие продолжения вычислений
    int iterationCounter = 0; //заодно посчитаем и количество итераций
    do{
      root = (1/rootDegree)*
          (
              (rootDegree-1)*rootTemp+
                  (number/(_pow(rootTemp,rootDegree-1))
                  )
          );
      iterationCounter++;
      goOn = (rootTemp - root).abs() >= epsilon;
      rootTemp = root;
    } while (goOn);

    //если вдруг ряд не сойдется...
    if(root==null){
      throw 'Не удалось найти корень за ${iterationCounter} итераций!';
    }
    return root;
  }
}


mixin mixUser{
  String getMailSystem(String email){
    String mailSystem = '';
    String atSign = '@';

    email = email.trim();

    String lastSignEmail = email.substring(email.length - 1);

    if (
      (email.isEmpty)           ||
      (email.length==1)         ||
      (!email.contains(atSign)) ||
      (lastSignEmail==atSign)
      )
      {
          throw Exception("Недопустимый формат email");
      }
    int atIndex = email.indexOf(atSign);
    for (int i=atIndex+1; i<=email.length-1; i++){
      mailSystem = mailSystem + email[i];
    }

    return mailSystem;
  }
}

class User{
  late String userName;
  late String email;

  User(this.userName, this.email);
}

class AdminUser extends User with mixUser{
    AdminUser(String userName, String email): super(userName, email);
}

 class GeneralUser extends User {
   GeneralUser(String userName, String email): super(userName, email);
 }

class UserManager<T extends User> with mixUser{
  List<User> userList = [];

  void addUser(user){
    userList.add(user);
  }

  void removeUser(user){
    userList.remove(user);
  }

  void userMailOutput(){
    for(var user in userList){
      if(user.userName=='admin'){
        print(getMailSystem(user.email));
      }
      else{
        print(user.email);
      }
    }
  }
}


class Gauss{
  static String _checkInputData(List matrix){
    //Проверим, что:
    //1. каждый элемент матрицы является числом с типом double
    //2. матрица прямоугольная, а не "произвольной формы" (в каждой строке одинаковое количество колонок)
    //3. количество колонок больше количества строк ровно на 1, с учетом коэффициентов при свободных членах
    //
    //Будем проверять до первой найденной ошибки (а не сообщать их все сразу, если их несколько)

    String errorMessage = '';

    int rowCount = 0; //количество строк в матрице
    int columnCount = 0; //количество колонок в матрице

    for (var row in matrix) {
      int columnCountInRow = 0; //количество колонок в текущей строке
      //(а вдруг в исходных данных количество колонок разное в разных строках?)

      for (var col in row){
        bool isDouble = col is double;
        if (!isDouble){
          errorMessage = 'ОШИБКА! В строке ${rowCount} в колонке ${columnCountInRow} не содержится число типа double!';
          break;
        }
        columnCountInRow++;
      }
      if (errorMessage !=''){
        break;
      }
      if ((rowCount !=0 ) & (columnCount != columnCountInRow)){
        errorMessage = 'ОШИБКА! В строке ${rowCount} количество колонок отличается от количества колонок в предыдущей строке!';
        break;
      }
      columnCount = columnCountInRow;
      rowCount++;
    }
    if(errorMessage==''){
      if (columnCount-rowCount!=1){
        errorMessage = ' ОШИБКА! Разница между количеством строк и количеством колонок отличается от 1!';
      }
    }
    return errorMessage;
  }

  List getRootsWithTriangleTypeMatrix(List matrix){

    //Проверим входные данные
    String errorMessage = _checkInputData(matrix);

    if (errorMessage !=''){
      print(errorMessage);
      print('Корни не могут быть найдены.');
      return [];
    }

    int n = matrix.first.length-1; //размерность матрицы: количество уравнений и неизвестных
    List roots = List.generate(n,(int index) => null,growable: false); //корни
    List bMatrix = []; //коэффициенты при свободных членах

    //Для удобства реализации алгоритма введем список с коэффициентами при свободных членах матрицы
    for (var row in matrix){
      double lastEl = row.last;
      bMatrix.add(lastEl);
    }

    int nn=n-1; //нумерация элементов в списке начинается с 0, а не с 1

    //Выполняем прямой ход (исключение переменных путем преобразования коэффициентов матрицы)
    for (int i=0; i<=nn-1; i++){
      for (int j=i+1; j<=nn; j++){
        matrix[j][i] = -matrix[j][i] / matrix[i][i];

        for (int k=i+1; k<=nn; k++){
          matrix[j][k] = matrix[j][k]+matrix[j][i]*matrix[i][k];
        } //k
        bMatrix[j] = bMatrix[j]+matrix[j][i]*bMatrix[i];
      } //j
    }//i
    roots[nn] = bMatrix[nn] / matrix[nn][nn];

    //Обратный ход
    for(int i=nn; i>=0; i--){
      var h = bMatrix[i];
      for (int j=i+1; j<=nn; j++){
        h = h - roots[j]*matrix[i][j];
      }
      roots[i] = h / matrix[i][i];
    }
    return roots;
  }
}
