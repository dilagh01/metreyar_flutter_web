class ErrorHandler {
  static String handleException(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Exception) {
      final errorString = error.toString().toLowerCase();
      
      if (errorString.contains('connection') || errorString.contains('network')) {
        return 'خطا در اتصال به اینترنت';
      } else if (errorString.contains('timeout')) {
        return ' timeout اتصال';
      } else if (errorString.contains('server')) {
        return 'خطای سرور';
      } else if (errorString.contains('authentication')) {
        return 'خطای احراز هویت';
      } else if (errorString.contains('authorization')) {
        return 'دسترسی غیرمجاز';
      } else if (errorString.contains('not found')) {
        return 'منبع یافت نشد';
      }
    }
    
    return 'خطای ناشناخته رخ داد';
  }

  static void logError(String location, dynamic error) {
    if (kDebugMode) {
      print('❌ Error at $location: $error');
    }
  }
}
