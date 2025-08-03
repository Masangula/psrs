import 'package:get/get.dart';
import 'package:psrs_frontend/app/modules/home/Models/job_model.dart';
import 'package:psrs_frontend/app/modules/home/providers/home_provider.dart';
import 'package:psrs_frontend/app/services/storage_service.dart';
import 'package:psrs_frontend/app/utils/aip_reponse.dart';

class HomeController extends GetxController {
  final StorageService storageService = Get.find<StorageService>();
  final selectedIndex = 0.obs;

  String get role => storageService.role ?? 'viewer'; 

  final HomeProvider _homeProvider = HomeProvider();

  var jobs = <Job>[].obs;
  var isLoading = false.obs;

  void switchTab(int index) {
    selectedIndex.value = index;
  }

   

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    isLoading.value = true;

    APIResponse response = await _homeProvider.fetchJobs();

    if (response.success) {
      try {
        jobs.value = jobFromJson(response.data); // Parse from JSON string
      } catch (e) {
        Get.snackbar("Error", "Failed to parse jobs.");
        jobs.clear();
      }
    } else {
      Get.snackbar("Error", response.message ?? "Could not fetch jobs");
    }

    isLoading.value = false;
  }
}
