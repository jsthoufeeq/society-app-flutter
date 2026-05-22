import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_endpoints.dart';
import 'auth_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  return AuthRepository(dio: dio);
});

class AuthRepository {
  final dio;
  
  // Set to false to use real API, true for mock testing
  static const bool _useMockData = true;
  
  const AuthRepository({required this.dio});

  Future<void> sendOtp(String phone) async {
    if (_useMockData) {
      // Mock: Just log and return
      print('Mock OTP sent to $phone');
      print('Use OTP: 123456 for testing');
      return;
    }
    await dio.post(ApiEndpoints.sendOtp, data: {'phone': phone});
  }

  Future<AuthResponse> verifyOtp(String phone, String otp) async {
    if (_useMockData) {
      // Mock: Accept any OTP but prefer 123456
      if (otp != '123456') {
        throw Exception('Invalid OTP. For testing, use: 123456');
      }
      print('Mock OTP verification successful for $phone');
      
      // Return mock auth response
      return AuthResponse(
        accessToken: 'mock_access_token_$phone',
        refreshToken: 'mock_refresh_token_$phone',
        userId: 'user_123',
        societyId: 'society_456',
      );
    }
    
    final response = await dio.post(
      ApiEndpoints.verifyOtp,
      data: {'phone': phone, 'otp': otp},
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await dio.post(ApiEndpoints.logout);
  }
}

