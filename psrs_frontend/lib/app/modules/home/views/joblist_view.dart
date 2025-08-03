import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psrs_frontend/app/modules/home/controllers/home_controller.dart';

class JobListView extends GetView<HomeController> {
  const JobListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.jobs.isEmpty) {
        return const Center(child: Text('No job listings available.'));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.jobs.length,
        itemBuilder: (_, index) {
          final job = controller.jobs[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(job.title ?? ''),
              subtitle: Text(
                '${job.department ?? ''} • ${job.location ?? ''}',
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tsh ${job.salary ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar("Coming soon", "Apply functionality will be added.");
                    },
                    child: const Text("Apply"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
