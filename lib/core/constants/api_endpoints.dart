class ApiEndpoints {
  ApiEndpoints._();

  // Switch between local dev and production
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api/v1', // Android emulator localhost
  );

  // Auth
  static const sendOtp      = '/auth/otp/send';
  static const verifyOtp    = '/auth/otp/verify';
  static const refreshToken = '/auth/token/refresh';
  static const logout       = '/auth/logout';

  // Society
  static const society      = '/society';
  static const societyById  = '/society/{id}';

  // Members
  static const members          = '/members';
  static const memberById       = '/members/{id}';
  static const familyByMember   = '/members/{id}/family';

  // Payments
  static const payments         = '/payments';
  static const createOrder      = '/payments/order';
  static const verifyPayment    = '/payments/verify';
  static const paymentHistory   = '/payments/history';
  static const receipt          = '/payments/{id}/receipt';

  // Noticeboard
  static const notices          = '/notices';
  static const noticeById       = '/notices/{id}';

  // Ads
  static const adCampaigns      = '/ads/campaigns';
  static const adImpression     = '/ads/impression';
  static const adClick          = '/ads/click';
}
