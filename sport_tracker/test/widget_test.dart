// test/unit/calculator_test.dart
import 'package:test/test.dart';
import 'package:sport_tracker/calculator.dart'; 

void main() {
  group('Calculator Tests', () {
    final calculator = Calculator();

    test('Addition works correctly', () {
      final result = calculator.add(2, 3);
      expect(result, 5); 
    });

    test('Subtraction works correctly', () {
      final result = calculator.subtract(10, 4);
      expect(result, 6); 
    });

    test('Addition with negative numbers', () {
      final result = calculator.add(-5, 3);
      expect(result, -2); 
    });

    test('Subtraction with zero', () {
      final result = calculator.subtract(7, 0);
      expect(result, 7); 
    });
  });
}