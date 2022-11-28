// ignore: file_names
import 'dart:math';
import 'package:get/get.dart';

class MathController extends GetxController {
  int _valueOne = 0;
  int _valueTwo = 0;
  int _valueThree = 0;
  Set<int> prime = <int>{};

  int get valueOne => _valueOne;
  int get valuetwo => _valueTwo;
  int get valueThree => _valueThree;

  set setValueOne(value) {
    _valueOne = value;
  }

  set setValueTwo(value) {
    _valueTwo = value;
  }

  set setValueThree(value) {
    _valueThree = value;
  }

  bool checkPrime(int num) {
    if (num <= 1) {
      return false;
    }

    for (int i = 2; i <= sqrt(num); i++) {
      if (num % i == 0) {
        return false;
      }
    }
    return true;
  }

  Set<int> get getPrime {
    prime = {};
    if (checkPrime(_valueOne)) {
      prime.add(_valueOne);
    }
    if (checkPrime(_valueTwo)) {
      prime.add(_valueTwo);
    }
    if (checkPrime(_valueThree)) {
      prime.add(_valueThree);
    }

    return prime;
  }
}
