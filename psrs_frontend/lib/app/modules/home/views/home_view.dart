import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psrs_frontend/app/modules/home/controllers/home_controller.dart';
import 'package:psrs_frontend/app/modules/home/views/application_list_view.dart';
import 'package:psrs_frontend/app/modules/home/views/joblist_view.dart';
import 'package:psrs_frontend/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    final tabs = [
      const Tab(text: 'Jobs'),
     const Tab(text: 'Applications'),
    ];

    final pages = [
      const JobListView(),
      const ApplicationListView(),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PSRS Recruitment System'),
          bottom: TabBar(tabs: tabs),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                 controller.storageService.logout(); 
                Get.offAllNamed(Routes.LOGIN); 
              },
            )
          ],
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
