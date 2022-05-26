import 'dart:math';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthApi{
  static final _auth = LocalAuthentication();
  
  static Future<bool> hasBiometrics() async{
    try {
  return await _auth.canCheckBiometrics;
} on PlatformException catch (e) {
  return false;
}
    
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if(!isAvailable) return false;
    try {
    return await _auth.authenticate(
      authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication required!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ],
      localizedReason: 'Scan face to Authenticate',
      options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
  );
} on PlatformException catch (e) {
  return true;
}
  }
}

