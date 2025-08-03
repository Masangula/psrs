import 'package:get/get.dart';
import 'package:psrs_frontend/app/routes/app_pages.dart';
import 'package:psrs_frontend/app/services/storage_service.dart';
import 'package:psrs_frontend/app/utils/aip_reponse.dart';
import 'package:psrs_frontend/app/utils/urls.dart';

class HomeProvider {
  final client = GetConnect(timeout: const Duration(seconds: 30));

  Future<APIResponse> fetchJobs() async {
  try {
    final response = await client.get(Urls.getJobs);

    if (response.statusCode == 403) {
      // Unauthorized or expired session
      final storageService = Get.find<StorageService>();
      storageService.logout();

      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar("Session Expired", "Please log in again.");
      
      return APIResponse(success: false, message: "Session expired.");
    }

    if (response.status.hasError) {
      return APIResponse(success: false, message: response.statusText);
    }

    return APIResponse(success: true, data: response.bodyString);
  } catch (e) {
    return APIResponse(success: false, message: e.toString());
  }
}
}