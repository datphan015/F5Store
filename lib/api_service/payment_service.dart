import 'package:dio/dio.dart';
import 'package:flutter_doanlt/models/User.dart';
import 'package:flutter_doanlt/models/Payment.dart';
import 'package:flutter_doanlt/models/Shoe.dart';  // Import model Payment nếu có

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.188:3000/api', // Địa chỉ IP của máy tính của bạn
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<List<Shoe>> getShoes() async {
    try {
      final response = await _dio.get('/shoes');
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      if (response.statusCode == 200) {
        List<Shoe> shoes = (response.data as List).map((json) => Shoe.fromJson(json)).toList();
        return shoes;
      } else {
        throw Exception('Failed to load shoes');
      }
    } catch (error) {
      if (error is DioError) {
        print('DioError: ${error.message}');
        if (error.response != null) {
          print('DioError response: ${error.response}');
        } else {
          print('DioError error: ${error.error}');
        }
      } else {
        print('Error: $error');
      }
      throw Exception('Failed to load shoes: $error');
    }
  }

  Future<Shoe> getShoeById(int id) async {
    try {
      final response = await _dio.get('/shoes/$id');
      if (response.statusCode == 200) {
        return Shoe.fromJson(response.data);
      } else {
        throw Exception('Shoe not found');
      }
    } catch (error) {
      throw Exception('Failed to load shoe: $error');
    }
  }

  Future<Shoe> createShoe(Shoe shoe) async {
    try {
      final response = await _dio.post(
        '/shoes',
        data: shoe.toJson(),
      );
      if (response.statusCode == 201) {
        return Shoe.fromJson(response.data);
      } else {
        throw Exception('Failed to create shoe');
      }
    } catch (error) {
      throw Exception('Failed to create shoe: $error');
    }
  }

  Future<Shoe> updateShoe(int id, Shoe shoe) async {
    try {
      final response = await _dio.put(
        '/shoes/$id',
        data: shoe.toJson(),
      );
      if (response.statusCode == 200) {
        return Shoe.fromJson(response.data);
      } else {
        throw Exception('Failed to update shoe');
      }
    } catch (error) {
      throw Exception('Failed to update shoe: $error');
    }
  }

  Future<void> deleteShoe(int id) async {
    try {
      final response = await _dio.delete('/shoes/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete shoe');
      }
    } catch (error) {
      throw Exception('Failed to delete shoe: $error');
    }
  }

  Future<User> register(User user) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to register');
      }
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }

  // Thêm các hàm cho xử lý thanh toán (payments)

  Future<Payment> createPayment(Payment payment) async {
    try {
      final response = await _dio.post(
        '/payments',
        data: payment.toJson(),
      );
      if (response.statusCode == 201) {
        return Payment.fromJson(response.data);
      } else {
        throw Exception('Failed to create payment');
      }
    } catch (error) {
      throw Exception('Failed to create payment: $error');
    }
  }

  Future<Payment> getPaymentById(String id) async {
    try {
      final response = await _dio.get('/payments/$id');
      if (response.statusCode == 200) {
        return Payment.fromJson(response.data);
      } else {
        throw Exception('Payment not found');
      }
    } catch (error) {
      throw Exception('Failed to load payment: $error');
    }
  }

  Future<List<Payment>> getPayments() async {
    try {
      final response = await _dio.get('/payments');
      if (response.statusCode == 200) {
        List<Payment> payments = (response.data as List).map((json) => Payment.fromJson(json)).toList();
        return payments;
      } else {
        throw Exception('Failed to load payments');
      }
    } catch (error) {
      throw Exception('Failed to load payments: $error');
    }
  }

  Future<void> updatePayment(String id, Payment payment) async {
    try {
      final response = await _dio.put(
        '/payments/$id',
        data: payment.toJson(),
      );
      if (response.statusCode != 204) {
        throw Exception('Failed to update payment');
      }
    } catch (error) {
      throw Exception('Failed to update payment: $error');
    }
  }

  Future<void> deletePayment(String id) async {
    try {
      final response = await _dio.delete('/payments/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete payment');
      }
    } catch (error) {
      throw Exception('Failed to delete payment: $error');
    }
  }
}
