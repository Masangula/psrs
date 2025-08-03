import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:psrs_frontend/app/utils/aip_reponse.dart';
import 'package:psrs_frontend/app/utils/urls.dart';

class LoginProvider {
  final ourClient = GetConnect(timeout: const Duration(minutes: 2));

  Future<APIResponse> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await ourClient.post(
        Urls.login,
        {"email": email, "password": password},
        headers: {
          // "Content-Type": "application/json",
          // "Accept": "application/json",
        },
      );

      if (kDebugMode) {
        debugPrint("RESPONSE: ${response.body}");
      }

      if (response.status.hasError) {
        return APIResponse(
          success: false,
          message: response.statusText ?? "An error occurred",
        );
      }

      // Parse JSON body
      final Map<String, dynamic> data = response.body;

      return APIResponse(
        success: true,
        message: "Login successful",
        data: data, // now it's a Map, not a String
      );
    } catch (exception) {
      if (kDebugMode) {
        debugPrint("EXCEPTION: $exception");
      }
      return APIResponse(success: false, message: exception.toString());
    }
  }
}
