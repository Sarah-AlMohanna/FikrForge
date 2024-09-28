import 'dart:io';

class InAppPaymentSetting {
  static const String shopperResultUrl= "com.sanjoob.user.payment";
  static const String merchantId= "MerchantId";
  static const String countryCode="JO";
  static getLang() {
    if (Platform.isIOS) {
      return  "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}